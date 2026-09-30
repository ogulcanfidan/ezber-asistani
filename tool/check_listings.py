"""Mağaza metinlerini (store/listings/*.txt) Play sınırlarına göre denetler ve
tek bir JSON dosyasında toplar."""
import json
import pathlib

ROOT = pathlib.Path(__file__).resolve().parent.parent / 'store' / 'listings'
LIMITS = {'TITLE': 30, 'SHORT': 80, 'NOTES': 500, 'FULL': 4000}

out, ok = {}, True
for path in sorted(ROOT.glob('*.txt')):
    parts, key = {}, None
    for line in path.read_text(encoding='utf-8').splitlines():
        if line.startswith('== '):
            key = line[3:].strip()
            parts[key] = []
        elif key:
            parts[key].append(line)
    entry = {k: '\n'.join(v).strip() for k, v in parts.items()}
    out[path.stem] = entry
    sizes = []
    for k, limit in LIMITS.items():
        # Play karakterleri UTF-16 birimi olarak sayar (emoji 2).
        n = len(entry[k].encode('utf-16-le')) // 2
        sizes.append(f'{k.lower()} {n}/{limit}')
        if n > limit or n == 0:
            ok = False
            sizes[-1] += ' !!'
    print(f'{path.stem:7}', ', '.join(sizes))

(ROOT / 'listings.json').write_text(json.dumps(out, ensure_ascii=False, indent=1), encoding='utf-8')
print('tamam' if ok else 'SINIR AŞILDI')
