"""Mağaza ekran görüntüleri: telefon görüntülerini 9:16 çerçeveye yerleştirir.

Play en fazla 2:1 oran kabul ediyor; telefonun 1080x2400 (9:20) görüntüleri
doğrudan yüklenemiyor. Marka degradesi + başlık + yuvarlatılmış görüntü.

python tool/make_screens.py  →  store/screenshots/framed/*.png
"""
import pathlib

from PIL import Image, ImageDraw, ImageFont

ROOT = pathlib.Path(__file__).resolve().parent.parent
SRC = ROOT / "store" / "screenshots"
OUT = SRC / "framed"
OUT.mkdir(parents=True, exist_ok=True)

W, H = 1080, 1920
TOP = (0x10, 0x6E, 0x7C)
BOTTOM = (0x2B, 0xC0, 0xA0)

CAPTIONS = {
    "1-prova": "Eller serbest prova",
    "2-karakter-ses": "Her karaktere ayrı ses",
    "3-modlar": "Her metne uygun çalışma modu",
    "en-1-rehearsal": "Rehearse hands-free",
    "en-2-characters-voices": "A voice for every character",
    "en-3-modes": "A mode for every text",
}


def gradient(w, h):
    small = Image.new("RGB", (64, 64))
    px = small.load()
    for y in range(64):
        for x in range(64):
            t = x / 63 * 0.35 + y / 63 * 0.65
            px[x, y] = tuple(int(TOP[i] + (BOTTOM[i] - TOP[i]) * t) for i in range(3))
    return small.resize((w, h), Image.BICUBIC)


font = ImageFont.truetype("C:/Windows/Fonts/segoeuib.ttf", 68)
for name, caption in CAPTIONS.items():
    shot = Image.open(SRC / f"{name}.png").convert("RGB")
    # Durum çubuğu (operatör adı, bildirim simgeleri) mağazada gereksiz.
    shot = shot.crop((0, 110, shot.width, shot.height))
    canvas = gradient(W, H)
    d = ImageDraw.Draw(canvas)
    tw = d.textlength(caption, font=font)
    d.text(((W - tw) / 2, 90), caption, font=font, fill="white")

    sh = H - 260 - 60
    sw = round(shot.width * sh / shot.height)
    shot = shot.resize((sw, sh), Image.LANCZOS)
    mask = Image.new("L", (sw, sh), 0)
    ImageDraw.Draw(mask).rounded_rectangle((0, 0, sw, sh), radius=40, fill=255)
    x, y = (W - sw) // 2, 260
    # İnce beyaz kenar: görüntü degradeden ayrılsın.
    d.rounded_rectangle((x - 6, y - 6, x + sw + 6, y + sh + 6), radius=46, fill=(255, 255, 255))
    canvas.paste(shot, (x, y), mask)
    canvas.save(OUT / f"{name}.png", optimize=True)

print("ok")
