#!/usr/bin/env python
"""CLI sottile sopra la libreria audiedit — uso da terminale o da un'IA.

Esempi:
    python cli.py scan-catalog
    python cli.py list-events
    python cli.py build
    python cli.py check-log
"""
from __future__ import annotations

import argparse
import json
import sys
from dataclasses import asdict

from audiedit import build as build_module
from audiedit import catalog, library, pool, state


def cmd_scan_catalog(args: argparse.Namespace) -> int:
    issues: list[str] = []
    entries = catalog.scan(issues=issues)
    catalog.save(entries)
    print(f"Trovate {len(entries)} voci, salvate in {catalog_path()}")
    if issues:
        print(f"Avvisi: {len(issues)} (prime 10)")
        for msg in issues[:10]:
            print(f"  ! {msg}")
    return 0


def catalog_path():
    from audiedit import config
    return config.CATALOG_JSON


def cmd_list_events(args: argparse.Namespace) -> int:
    events = state.load()
    if args.json:
        print(json.dumps([asdict(e) for e in events], ensure_ascii=False, indent=2))
        return 0
    for e in events:
        atten = f"curva {e.attenuation_curve}" if e.attenuation_curve else "nessuna"
        print(f"- {e.cue}  [{e.pattern}]  attenuazione={atten}  mono={e.mono}  file={len(e.pool)}")
    return 0


def cmd_build(args: argparse.Namespace) -> int:
    from audiedit import hooks

    events = state.load()
    if args.hooks:
        written = hooks.write_all(events)
        print(f"Hook rigenerati: {len(written)} file")
    result = build_module.build(events)
    print("OK" if result.success else "FALLITO")
    print(result.log[-3000:])
    if result.xap_backup:
        print(f"backup .xap: {result.xap_backup}")
    if result.sounds_backup:
        print(f"backup banchi: {result.sounds_backup}")
    return 0 if result.success else 1


def cmd_check_log(args: argparse.Namespace) -> int:
    errors = library.read_log_errors()
    if not errors:
        print("Nessun errore 'Error loading soundbank' nel log più recente.")
        return 0
    print(f"{len(errors)} errore/i trovati:")
    for err in errors:
        print(f"  {err}")
    return 1


def cmd_pool_status(args: argparse.Namespace) -> int:
    from audiedit import config

    manifest = pool.reconcile()
    for category in config.POOL_CATEGORIES:
        files = [rel for rel, rec in manifest.items() if rec.status == category]
        print(f"{category}: {len(files)} file")
        if args.verbose:
            for rel in sorted(files):
                print(f"  {rel}")
    return 0


def main(argv: list[str] | None = None) -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    sub = parser.add_subparsers(dest="command", required=True)

    sub.add_parser("scan-catalog").set_defaults(func=cmd_scan_catalog)

    p_list = sub.add_parser("list-events")
    p_list.add_argument("--json", action="store_true")
    p_list.set_defaults(func=cmd_list_events)

    p_build = sub.add_parser("build")
    p_build.add_argument(
        "--no-hooks", dest="hooks", action="store_false", default=True,
        help="non rigenerare gli hook (solo banco audio)",
    )
    p_build.set_defaults(func=cmd_build)

    sub.add_parser("check-log").set_defaults(func=cmd_check_log)

    p_pool = sub.add_parser("pool-status")
    p_pool.add_argument("-v", "--verbose", action="store_true")
    p_pool.set_defaults(func=cmd_pool_status)

    args = parser.parse_args(argv)
    return args.func(args)


if __name__ == "__main__":
    sys.exit(main())
