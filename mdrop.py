#!/usr/bin/env python3
"""
mdrop.py
Converts a PDF to Markdown. Uses native text extraction where available,
falls back to OCR (Tesseract) for pages with no extractable text.

Usage: python3 mdrop.py /path/to/file.pdf
Output: /path/to/file.md (same folder as source)
"""

import sys
import os
from pathlib import Path

import fitz  # PyMuPDF
import pytesseract
from PIL import Image
import io

MIN_TEXT_CHARS = 20  # below this, treat page as image-only and OCR it
OCR_DPI = 300


def extract_native_text(page):
    text = page.get_text("text")
    return text.strip()


def ocr_page(page):
    pix = page.get_pixmap(dpi=OCR_DPI)
    img = Image.open(io.BytesIO(pix.tobytes("png")))
    text = pytesseract.image_to_string(img)
    return text.strip()


def page_to_markdown(text):
    lines = text.split("\n")
    out = []
    for line in lines:
        stripped = line.strip()
        if not stripped:
            out.append("")
            continue
        out.append(stripped)
    return "\n".join(out)


def convert(pdf_path):
    pdf_path = Path(pdf_path)
    if not pdf_path.exists():
        print(f"File not found: {pdf_path}", file=sys.stderr)
        sys.exit(1)

    doc = fitz.open(pdf_path)
    md_parts = [f"# {pdf_path.stem}\n"]

    for i, page in enumerate(doc):
        native = extract_native_text(page)
        if len(native) >= MIN_TEXT_CHARS:
            page_text = native
            method = "text"
        else:
            page_text = ocr_page(page)
            method = "ocr"

        md_parts.append(f"\n<!-- page {i + 1} ({method}) -->\n")
        md_parts.append(page_to_markdown(page_text))

    doc.close()

    output_path = pdf_path.with_suffix(".md")
    output_path.write_text("\n".join(md_parts), encoding="utf-8")
    print(f"Saved: {output_path}")
    return output_path


if __name__ == "__main__":
    if len(sys.argv) < 2:
        print("Usage: python3 mdrop.py <file1.pdf> [file2.pdf ...]", file=sys.stderr)
        sys.exit(1)

    for arg in sys.argv[1:]:
        convert(arg)
