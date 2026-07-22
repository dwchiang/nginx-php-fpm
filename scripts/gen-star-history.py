#!/usr/bin/env python3
"""Generate the Star History chart for this repository.

GitHub now requires authentication on the stargazers endpoint, which is why the
third-party star-history.com badge stopped rendering for everyone. This script
fetches the data with our own token and renders a self-contained SVG that is
committed to the repo, so the README never depends on an external service again.

Standard library only, on purpose: this repo has no build toolchain and none
should be introduced just to draw one chart.

Usage:
    GITHUB_TOKEN=... python3 scripts/gen-star-history.py
    GITHUB_TOKEN=... python3 scripts/gen-star-history.py --repo owner/name --out-dir docs

Outputs (relative to the repo root):
    docs/star-history.json   every stargazer's starred_at timestamp
    docs/star-history.svg    cumulative star count over time

The rendering is a pure function of the data: the x axis ends at the most recent
star rather than at "today", so an unchanged star count produces a byte-identical
SVG and the scheduled workflow has nothing to commit.
"""

from __future__ import annotations

import argparse
import json
import os
import sys
import time
import urllib.error
import urllib.request
from datetime import datetime, timezone
from pathlib import Path

API_ROOT = "https://api.github.com"
PER_PAGE = 100
MAX_RETRIES = 4

# Palette validated with the dataviz palette validator against both GitHub
# surfaces, #ffffff (light) and #0d1117 (dark): lightness band, chroma floor and
# contrast all pass on both, so one file serves both themes and Docker Hub.
# Contrast ratios - accent 3.61 (light) / 5.24 (dark), ink 4.55 / 4.16.
ACCENT = "#4088e0"
INK = "#6e7781"
FONT = ("-apple-system, BlinkMacSystemFont, 'Segoe UI', Helvetica, "
        "Arial, sans-serif")

WIDTH, HEIGHT = 840, 420
PAD_TOP, PAD_RIGHT, PAD_BOTTOM, PAD_LEFT = 64, 96, 52, 64


# --------------------------------------------------------------------------- #
# data
# --------------------------------------------------------------------------- #

def fetch_starred_at(repo: str, token: str) -> list[str]:
    """Return every stargazer's starred_at timestamp, oldest first."""
    stamps: list[str] = []
    page = 1
    while True:
        url = f"{API_ROOT}/repos/{repo}/stargazers?per_page={PER_PAGE}&page={page}"
        batch = _get_json(url, token)
        if not batch:
            break
        for entry in batch:
            # The star+json media type turns each element into
            # {"starred_at": ..., "user": {...}} instead of a bare user.
            starred_at = entry.get("starred_at") if isinstance(entry, dict) else None
            if starred_at:
                stamps.append(starred_at)
        if len(batch) < PER_PAGE:
            break
        page += 1
    stamps.sort()
    return stamps


def _get_json(url: str, token: str):
    request = urllib.request.Request(url, headers={
        "Accept": "application/vnd.github.star+json",
        "Authorization": f"Bearer {token}",
        "User-Agent": "nginx-php-fpm-star-history",
        "X-GitHub-Api-Version": "2022-11-28",
    })
    for attempt in range(1, MAX_RETRIES + 1):
        try:
            with urllib.request.urlopen(request, timeout=30) as response:
                return json.loads(response.read().decode("utf-8"))
        except urllib.error.HTTPError as error:
            # 403/429 are the secondary rate limit; everything else is fatal.
            if error.code in (403, 429) and attempt < MAX_RETRIES:
                delay = int(error.headers.get("Retry-After") or 2 ** attempt)
                print(f"rate limited, sleeping {delay}s", file=sys.stderr)
                time.sleep(delay)
                continue
            body = error.read().decode("utf-8", "replace")[:200]
            raise SystemExit(f"GitHub API {error.code} for {url}: {body}")
        except urllib.error.URLError as error:
            if attempt < MAX_RETRIES:
                time.sleep(2 ** attempt)
                continue
            raise SystemExit(f"network error for {url}: {error}")
    return []


# --------------------------------------------------------------------------- #
# scales
# --------------------------------------------------------------------------- #

def nice_ticks(top: int, count: int = 4) -> list[int]:
    """Round tick values from 0 to at least `top`, using 1/2/2.5/5 x 10^n steps."""
    if top <= 0:
        return [0, 1]
    raw = top / count
    magnitude = 10 ** int(len(str(int(raw))) - 1) if raw >= 1 else 1
    for multiplier in (1, 2, 2.5, 5, 10):
        step = multiplier * magnitude
        if step * count >= top:
            break
    step = int(step) if step >= 1 else 1
    return list(range(0, step * count + 1, step))


def year_ticks(first: datetime, last: datetime) -> list[datetime]:
    """January 1st of every year covered by the data, plus the first year."""
    years = range(first.year, last.year + 1)
    ticks = [datetime(year, 1, 1, tzinfo=timezone.utc) for year in years]
    return [tick for tick in ticks if first <= tick <= last]


# --------------------------------------------------------------------------- #
# rendering
# --------------------------------------------------------------------------- #

def escape(text: str) -> str:
    return (text.replace("&", "&amp;").replace("<", "&lt;")
                .replace(">", "&gt;").replace('"', "&quot;"))


def render_svg(repo: str, stamps: list[str]) -> str:
    if not stamps:
        raise SystemExit("no stargazers returned; refusing to render an empty chart")

    moments = [datetime.strptime(s, "%Y-%m-%dT%H:%M:%SZ").replace(tzinfo=timezone.utc)
               for s in stamps]
    first, last = moments[0], moments[-1]
    total = len(moments)
    span_seconds = max((last - first).total_seconds(), 1.0)

    plot_w = WIDTH - PAD_LEFT - PAD_RIGHT
    plot_h = HEIGHT - PAD_TOP - PAD_BOTTOM
    ticks = nice_ticks(total)
    y_top = ticks[-1]

    def x_of(moment: datetime) -> float:
        return PAD_LEFT + plot_w * ((moment - first).total_seconds() / span_seconds)

    def y_of(value: float) -> float:
        return PAD_TOP + plot_h * (1 - value / y_top)

    points = [(x_of(moment), y_of(index)) for index, moment in enumerate(moments, start=1)]
    # Anchor the series at zero on the day of the first star so the area closes
    # on the baseline instead of starting mid-air.
    points.insert(0, (PAD_LEFT, y_of(0)))
    line = " ".join(f"{x:.2f},{y:.2f}" for x, y in points)
    area = (f"{PAD_LEFT:.2f},{y_of(0):.2f} " + line +
            f" {points[-1][0]:.2f},{y_of(0):.2f}")

    out: list[str] = []
    add = out.append
    add(f'<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 {WIDTH} {HEIGHT}" '
        f'width="{WIDTH}" height="{HEIGHT}" role="img" '
        f'aria-labelledby="chart-title chart-desc" font-family="{FONT}">')
    add(f'<title id="chart-title">Star history of {escape(repo)}</title>')
    add(f'<desc id="chart-desc">Cumulative GitHub stars from '
        f'{first:%Y-%m-%d} to {last:%Y-%m-%d}, reaching {total} stars.</desc>')
    add('<defs><linearGradient id="fade" x1="0" y1="0" x2="0" y2="1">'
        f'<stop offset="0%" stop-color="{ACCENT}" stop-opacity="0.28"/>'
        f'<stop offset="100%" stop-color="{ACCENT}" stop-opacity="0.02"/>'
        '</linearGradient></defs>')

    add(f'<text x="{PAD_LEFT}" y="30" fill="{INK}" font-size="16" '
        f'font-weight="600">Star history</text>')
    add(f'<text x="{PAD_LEFT}" y="48" fill="{INK}" font-size="12" '
        f'opacity="0.85">{escape(repo)}</text>')

    # Horizontal grid and y labels. Recessive: the data is the subject.
    for tick in ticks:
        y = y_of(tick)
        add(f'<line x1="{PAD_LEFT}" y1="{y:.2f}" x2="{PAD_LEFT + plot_w}" '
            f'y2="{y:.2f}" stroke="{INK}" stroke-opacity="0.18" stroke-width="1"/>')
        add(f'<text x="{PAD_LEFT - 12}" y="{y + 4:.2f}" fill="{INK}" '
            f'font-size="12" text-anchor="end">{tick}</text>')

    for tick in year_ticks(first, last):
        x = x_of(tick)
        add(f'<line x1="{x:.2f}" y1="{PAD_TOP}" x2="{x:.2f}" '
            f'y2="{PAD_TOP + plot_h}" stroke="{INK}" stroke-opacity="0.12" '
            f'stroke-width="1"/>')
        add(f'<text x="{x:.2f}" y="{PAD_TOP + plot_h + 22}" fill="{INK}" '
            f'font-size="12" text-anchor="middle">{tick.year}</text>')

    add(f'<polygon points="{area}" fill="url(#fade)"/>')
    add(f'<polyline points="{line}" fill="none" stroke="{ACCENT}" '
        f'stroke-width="2" stroke-linejoin="round" stroke-linecap="round"/>')

    # One direct label on the final value instead of a number on every point.
    end_x, end_y = points[-1]
    add(f'<circle cx="{end_x:.2f}" cy="{end_y:.2f}" r="4" fill="{ACCENT}"/>')
    add(f'<text x="{end_x + 12:.2f}" y="{end_y - 6:.2f}" fill="{INK}" '
        f'font-size="15" font-weight="600">{total}</text>')
    add(f'<text x="{end_x + 12:.2f}" y="{end_y + 10:.2f}" fill="{INK}" '
        f'font-size="11" opacity="0.85">stars</text>')

    add(f'<text x="{PAD_LEFT}" y="{HEIGHT - 12}" fill="{INK}" font-size="11" '
        f'opacity="0.75">Latest star {last:%Y-%m-%d} '
        f'&#183; source: GitHub stargazers API</text>')
    add('</svg>')
    return "\n".join(out) + "\n"


# --------------------------------------------------------------------------- #

def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--repo", default="dwchiang/nginx-php-fpm")
    parser.add_argument("--out-dir", default="docs")
    parser.add_argument("--token", default=None)
    args = parser.parse_args()

    token = args.token or os.environ.get("GITHUB_TOKEN") or os.environ.get("GH_TOKEN")
    if not token:
        raise SystemExit(
            "a token is required: the stargazers endpoint returns 401 without one.\n"
            "set GITHUB_TOKEN (fine-grained token needs only Metadata: Read-only)")

    stamps = fetch_starred_at(args.repo, token)
    print(f"fetched {len(stamps)} stargazers for {args.repo}", file=sys.stderr)

    out_dir = Path(args.out_dir)
    out_dir.mkdir(parents=True, exist_ok=True)
    (out_dir / "star-history.json").write_text(
        json.dumps({"repo": args.repo, "total": len(stamps), "starred_at": stamps},
                   indent=2) + "\n", encoding="utf-8")
    (out_dir / "star-history.svg").write_text(
        render_svg(args.repo, stamps), encoding="utf-8")
    print(f"wrote {out_dir}/star-history.json and {out_dir}/star-history.svg",
          file=sys.stderr)
    return 0


if __name__ == "__main__":
    sys.exit(main())
