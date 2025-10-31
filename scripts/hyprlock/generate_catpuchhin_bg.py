from pathlib import Path
import shutil
import subprocess
import os

def build_background_svg(flavor: str, label: str, background_base: str, work_dir: str,
                         color_window_bg: str, color_accent_bg: str, variant: str = "") -> Path:
    """
    Generate a background.jpg from a base SVG with color replacements.

    Args:
        flavor: Flavor name (e.g., 'gray0')
        label: Color label (e.g., 'ctp_on_line')
        background_base: Path to the base SVG
        work_dir: Working directory for output
        color_window_bg: Color to replace #ffffff
        color_accent_bg: Color to replace #6e6c7e and #2f2c3e
        variant: Optional variant string, e.g., 'flat' or 'amoled'

    Returns:
        Path to the generated background.jpg
    """
    work_dir_path = Path(work_dir)
    work_dir_path.mkdir(parents=True, exist_ok=True)

    # SVG file name
    suffix = f"_{variant}" if variant else ""
    svg_name = f"{flavor}_{label}{suffix}_ctp_on_line_background.svg"
    background_svg = work_dir_path / svg_name

    # Copy base SVG
    shutil.copy(background_base, background_svg)

    # Read and replace colors
    content = background_svg.read_text()
    content = content.replace('sodipodi:docname="gray0_ctp_on_line_background.svg"',
                              f'sodipodi:docname="{svg_name}"')
    content = content.replace("fill:#ffffff;", f"fill:{color_window_bg};")
    content = content.replace("stroke:#6e6c7e;", f"stroke:{color_accent_bg};")
    content = content.replace("fill:#2f2c3e", f"fill:{color_accent_bg}")
    background_svg.write_text(content)

    # Convert to JPG using ImageMagick
    background_jpg = work_dir_path / "background.jpg"
    subprocess.run(["magick", str(background_svg), str(background_jpg)], check=True)

    return background_jpg


# Example usage
if __name__ == "__main__":
    flavor = "gray0"
    label = "ctp_on_line"
    work_dir = "/home/evil-hypr/.config/hypr/assets/"
    background_base = os.path.join(work_dir, "hyprlock_bg.svg")
    color_window_bg = "#E0B0FF"   # replace with your desired color
    color_accent_bg = "#FF8800"   # replace with your desired color

    jpg_path = build_background_svg(flavor, label, background_base, work_dir,
                                    color_window_bg, color_accent_bg, variant="")
    print(f"Generated background image: {jpg_path}")

