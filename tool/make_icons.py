"""Ezber Asistanı simgesi ve mağaza görselleri (mikrofon tasarımı).

Çalıştırma: python tool/make_icons.py
Üretir: assets/icon/*.png (flutter_launcher_icons girdisi) ve
store/ (Play Console için 512 simge ve 1024x500 öne çıkan görsel).
Sonra: dart run flutter_launcher_icons
"""
import pathlib

from PIL import Image, ImageDraw, ImageFont

ROOT = pathlib.Path(__file__).resolve().parent.parent
ICON = ROOT / "assets" / "icon"
STORE = ROOT / "store"
ICON.mkdir(parents=True, exist_ok=True)
STORE.mkdir(parents=True, exist_ok=True)

S = 4096  # Yüksek çözünürlükte çizip küçültüyoruz (kenar yumuşatma).
TOP = (0x10, 0x6E, 0x7C)  # petrol
BOTTOM = (0x2B, 0xC0, 0xA0)  # turkuaz
WHITE = (255, 255, 255, 255)
FADED = (255, 255, 255, 140)


def gradient(w, h):
    small = Image.new("RGBA", (64, 64))
    px = small.load()
    for y in range(64):
        for x in range(64):
            t = x / 63 * 0.35 + y / 63 * 0.65
            px[x, y] = tuple(int(TOP[i] + (BOTTOM[i] - TOP[i]) * t) for i in range(3)) + (255,)
    return small.resize((w, h), Image.BICUBIC)


def bar(d, x0, y, x1, h, fill):
    d.rounded_rectangle((x0, y - h / 2, x1, y + h / 2), radius=h / 2, fill=fill)


def foreground(size=S, scale=1.0):
    """Mikrofon + sağında konuşma satırları; son satır noktalı (gizlenen
    kelimeler). Şeffaf zemin. [scale] < 1: uyarlanabilir simgenin güvenli
    alanına (ortadaki ~%66) sığdırmak için."""
    img = Image.new("RGBA", (size, size), (0, 0, 0, 0))
    d = ImageDraw.Draw(img)
    c = size / 2

    def p(v):  # 0..1 koordinatını ölçekle, merkezden
        return c + (v - 0.5) * size * scale

    u = size * scale
    mx, my = p(0.36), p(0.44)
    mw, mh = u * 0.16, u * 0.30
    d.rounded_rectangle((mx - mw / 2, my - mh / 2, mx + mw / 2, my + mh / 2), radius=mw / 2, fill=WHITE)
    lw = max(1, int(u * 0.028))
    d.arc((mx - mw * 0.95, my - mh * 0.15, mx + mw * 0.95, my + mh * 0.62), 0, 180, fill=WHITE, width=lw)
    d.line((mx, my + mh * 0.62, mx, my + mh * 0.82), fill=WHITE, width=lw)
    d.line((mx - mw * 0.55, my + mh * 0.82, mx + mw * 0.55, my + mh * 0.82), fill=WHITE, width=lw)

    h = u * 0.05
    bar(d, p(0.52), p(0.36), p(0.80), h, WHITE)
    bar(d, p(0.52), p(0.47), p(0.72), h, WHITE)
    for a, b in ((0.52, 0.58), (0.62, 0.68), (0.72, 0.78)):
        bar(d, p(a), p(0.58), p(b), h, FADED)
    return img


def save(img, path, size):
    img.resize((size, size), Image.LANCZOS).save(path)


# 1) Eski tip (tam) simge: yuvarlatılmış kare zemin + ön plan.
full = Image.new("RGBA", (S, S), (0, 0, 0, 0))
mask = Image.new("L", (S, S), 0)
ImageDraw.Draw(mask).rounded_rectangle((0, 0, S, S), radius=S * 0.22, fill=255)
full.paste(gradient(S, S), (0, 0), mask)
full.alpha_composite(foreground())
save(full, ICON / "icon.png", 1024)

# 2) Uyarlanabilir simge: arka plan ayrı, ön plan güvenli alana küçültülmüş.
save(gradient(S, S), ICON / "background.png", 1024)
save(foreground(scale=0.84), ICON / "foreground.png", 1024)

# 3) Play Console: 512x512 simge (kare, köşeleri Play yuvarlar).
store_icon = gradient(S, S)
store_icon.alpha_composite(foreground())
store_icon.convert("RGB").resize((512, 512), Image.LANCZOS).save(STORE / "play-icon-512.png")

# 4) Öne çıkan görsel 1024x500, mağaza dili başına (Türkçe varsayılan + İngilizce).
FEATURE = {
    "": ("Ezber Asistanı", "Replik, şiir ve sunum ezberle", "Eller serbest • Suflör • 10 dil"),
    "-en": ("Memorize", "Learn lines, poems and speeches", "Hands-free • Prompter • 10 languages"),
}
for suffix, (t1, t2, t3) in FEATURE.items():
    W, H = 1024 * 4, 500 * 4
    fg = gradient(W, H)
    fg.alpha_composite(foreground(size=int(H * 0.9), scale=1.0), (int(W * 0.0), int(H * 0.05)))
    d = ImageDraw.Draw(fg)
    tx = int(W * 0.40)
    maxw = W * 0.94 - tx  # sağda Play'in kırpabileceği kenar payı kalsın

    def fit(path, size, *texts):
        # Uzun dillerde (Almanca vb.) yazı taşmasın: sığana kadar küçült.
        while True:
            f = ImageFont.truetype(path, size)
            if max(d.textlength(t, font=f) for t in texts) <= maxw:
                return f
            size = int(size * 0.95)

    title = fit("C:/Windows/Fonts/segoeuib.ttf", int(H * 0.16), t1)
    sub = fit("C:/Windows/Fonts/segoeui.ttf", int(H * 0.075), t2, t3)
    soft = (230, 255, 248, 255)
    d.text((tx, int(H * 0.28)), t1, font=title, fill=WHITE)
    d.text((tx, int(H * 0.50)), t2, font=sub, fill=soft)
    d.text((tx, int(H * 0.61)), t3, font=sub, fill=soft)
    fg.convert("RGB").resize((1024, 500), Image.LANCZOS).save(STORE / f"feature-graphic-1024x500{suffix}.png")

print("ok")
