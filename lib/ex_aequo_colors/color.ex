defmodule ExAequoColors.Color do
  @moduledoc false

  @names %{
    aqua: {0, 255, 255},
    aquamarine1: {95, 255, 215},
    aquamarine3: {95, 215, 175},
    azure1: {240, 255, 255},
    black: 30,
    blue1: {0, 0, 255},
    blue3: {0, 0, 175},
    blue: 34,
    blue_violet: {95, 0, 255},
    bold: 1,
    cadet_blue: {95, 175, 135},
    chartreuse1: {135, 255, 0},
    chartreuse2: {95, 255, 0},
    chartreuse3: {95, 175, 0},
    chartreuse4: {95, 135, 0},
    color0: {:color, 0},
    color1: {:color, 1},
    color2: {:color, 2},
    color3: {:color, 3},
    color4: {:color, 4},
    color5: {:color, 5},
    color6: {:color, 6},
    color7: {:color, 7},
    color8: {:color, 8},
    color9: {:color, 9},
    color10: {:color, 10},
    color11: {:color, 11},
    color12: {:color, 12},
    color13: {:color, 13},
    color14: {:color, 14},
    color15: {:color, 15},
    color16: {:color, 16},
    color17: {:color, 17},
    color18: {:color, 18},
    color19: {:color, 19},
    color20: {:color, 20},
    color21: {:color, 21},
    color22: {:color, 22},
    color23: {:color, 23},
    color24: {:color, 24},
    color25: {:color, 25},
    color26: {:color, 26},
    color27: {:color, 27},
    color28: {:color, 28},
    color29: {:color, 29},
    color30: {:color, 30},
    color31: {:color, 31},
    color32: {:color, 32},
    color33: {:color, 33},
    color34: {:color, 34},
    color35: {:color, 35},
    color36: {:color, 36},
    color37: {:color, 37},
    color38: {:color, 38},
    color39: {:color, 39},
    color40: {:color, 40},
    color41: {:color, 41},
    color42: {:color, 42},
    color43: {:color, 43},
    color44: {:color, 44},
    color45: {:color, 45},
    color46: {:color, 46},
    color47: {:color, 47},
    color48: {:color, 48},
    color49: {:color, 49},
    color50: {:color, 50},
    color51: {:color, 51},
    color52: {:color, 52},
    color53: {:color, 53},
    color54: {:color, 54},
    color55: {:color, 55},
    color56: {:color, 56},
    color57: {:color, 57},
    color58: {:color, 58},
    color59: {:color, 59},
    color60: {:color, 60},
    color61: {:color, 61},
    color62: {:color, 62},
    color63: {:color, 63},
    color64: {:color, 64},
    color65: {:color, 65},
    color66: {:color, 66},
    color67: {:color, 67},
    color68: {:color, 68},
    color69: {:color, 69},
    color70: {:color, 70},
    color71: {:color, 71},
    color72: {:color, 72},
    color73: {:color, 73},
    color74: {:color, 74},
    color75: {:color, 75},
    color76: {:color, 76},
    color77: {:color, 77},
    color78: {:color, 78},
    color79: {:color, 79},
    color80: {:color, 80},
    color81: {:color, 81},
    color82: {:color, 82},
    color83: {:color, 83},
    color84: {:color, 84},
    color85: {:color, 85},
    color86: {:color, 86},
    color87: {:color, 87},
    color88: {:color, 88},
    color89: {:color, 89},
    color90: {:color, 90},
    color91: {:color, 91},
    color92: {:color, 92},
    color93: {:color, 93},
    color94: {:color, 94},
    color95: {:color, 95},
    color96: {:color, 96},
    color97: {:color, 97},
    color98: {:color, 98},
    color99: {:color, 99},
    color100: {:color, 100},
    color101: {:color, 101},
    color102: {:color, 102},
    color103: {:color, 103},
    color104: {:color, 104},
    color105: {:color, 105},
    color106: {:color, 106},
    color107: {:color, 107},
    color108: {:color, 108},
    color109: {:color, 109},
    color110: {:color, 110},
    color111: {:color, 111},
    color112: {:color, 112},
    color113: {:color, 113},
    color114: {:color, 114},
    color115: {:color, 115},
    color116: {:color, 116},
    color117: {:color, 117},
    color118: {:color, 118},
    color119: {:color, 119},
    color120: {:color, 120},
    color121: {:color, 121},
    color122: {:color, 122},
    color123: {:color, 123},
    color124: {:color, 124},
    color125: {:color, 125},
    color126: {:color, 126},
    color127: {:color, 127},
    color128: {:color, 128},
    color129: {:color, 129},
    color130: {:color, 130},
    color131: {:color, 131},
    color132: {:color, 132},
    color133: {:color, 133},
    color134: {:color, 134},
    color135: {:color, 135},
    color136: {:color, 136},
    color137: {:color, 137},
    color138: {:color, 138},
    color139: {:color, 139},
    color140: {:color, 140},
    color141: {:color, 141},
    color142: {:color, 142},
    color143: {:color, 143},
    color144: {:color, 144},
    color145: {:color, 145},
    color146: {:color, 146},
    color147: {:color, 147},
    color148: {:color, 148},
    color149: {:color, 149},
    color150: {:color, 150},
    color151: {:color, 151},
    color152: {:color, 152},
    color153: {:color, 153},
    color154: {:color, 154},
    color155: {:color, 155},
    color156: {:color, 156},
    color157: {:color, 157},
    color158: {:color, 158},
    color159: {:color, 159},
    color160: {:color, 160},
    color161: {:color, 161},
    color162: {:color, 162},
    color163: {:color, 163},
    color164: {:color, 164},
    color165: {:color, 165},
    color166: {:color, 166},
    color167: {:color, 167},
    color168: {:color, 168},
    color169: {:color, 169},
    color170: {:color, 170},
    color171: {:color, 171},
    color172: {:color, 172},
    color173: {:color, 173},
    color174: {:color, 174},
    color175: {:color, 175},
    color176: {:color, 176},
    color177: {:color, 177},
    color178: {:color, 178},
    color179: {:color, 179},
    color180: {:color, 180},
    color181: {:color, 181},
    color182: {:color, 182},
    color183: {:color, 183},
    color184: {:color, 184},
    color185: {:color, 185},
    color186: {:color, 186},
    color187: {:color, 187},
    color188: {:color, 188},
    color189: {:color, 189},
    color190: {:color, 190},
    color191: {:color, 191},
    color192: {:color, 192},
    color193: {:color, 193},
    color194: {:color, 194},
    color195: {:color, 195},
    color196: {:color, 196},
    color197: {:color, 197},
    color198: {:color, 198},
    color199: {:color, 199},
    color200: {:color, 200},
    color201: {:color, 201},
    color202: {:color, 202},
    color203: {:color, 203},
    color204: {:color, 204},
    color205: {:color, 205},
    color206: {:color, 206},
    color207: {:color, 207},
    color208: {:color, 208},
    color209: {:color, 209},
    color210: {:color, 210},
    color211: {:color, 211},
    color212: {:color, 212},
    color213: {:color, 213},
    color214: {:color, 214},
    color215: {:color, 215},
    color216: {:color, 216},
    color217: {:color, 217},
    color218: {:color, 218},
    color219: {:color, 219},
    color220: {:color, 220},
    color221: {:color, 221},
    color222: {:color, 222},
    color223: {:color, 223},
    color224: {:color, 224},
    color225: {:color, 225},
    color226: {:color, 226},
    color227: {:color, 227},
    color228: {:color, 228},
    color229: {:color, 229},
    color230: {:color, 230},
    color231: {:color, 231},
    color232: {:color, 232},
    color233: {:color, 233},
    color234: {:color, 234},
    color235: {:color, 235},
    color236: {:color, 236},
    color237: {:color, 237},
    color238: {:color, 238},
    color239: {:color, 239},
    color240: {:color, 240},
    color241: {:color, 241},
    color242: {:color, 242},
    color243: {:color, 243},
    color244: {:color, 244},
    color245: {:color, 245},
    color246: {:color, 246},
    color247: {:color, 247},
    color248: {:color, 248},
    color249: {:color, 249},
    color250: {:color, 250},
    color251: {:color, 251},
    color252: {:color, 252},
    color253: {:color, 253},
    color254: {:color, 254},
    color255: {:color, 255},
    cornflower_blue: {95, 135, 255},
    cornsilk1: {255, 255, 215},
    cyan1: {0, 255, 255},
    cyan2: {0, 255, 215},
    cyan3: {0, 215, 175},
    cyan: 36,
    dark_blue: {0, 0, 135},
    dark_cyan: {0, 175, 135},
    dark_goldenrod: {175, 135, 0},
    dark_green: {0, 95, 0},
    dark_khaki: {175, 175, 95},
    dark_magenta: {135, 0, 135},
    dark_olive_green1: {215, 255, 95},
    dark_olive_green2: {175, 255, 95},
    dark_olive_green3: {135, 175, 95},
    dark_orange3: {175, 95, 0},
    dark_orange: {255, 135, 0},
    dark_red: {95, 0, 0},
    dark_sea_green1: {175, 255, 215},
    dark_sea_green2: {175, 215, 175},
    dark_sea_green3: {135, 215, 175},
    dark_sea_green4: {95, 135, 95},
    dark_sea_green: {135, 175, 135},
    dark_slate_gray1: {135, 255, 255},
    dark_slate_gray2: {95, 255, 255},
    dark_slate_gray3: {135, 215, 215},
    dark_turquoise: {0, 215, 215},
    dark_violet: {135, 0, 215},
    deep_pink1: {255, 0, 135},
    deep_pink2: {255, 0, 95},
    deep_pink3: {215, 0, 95},
    deep_pink4: {95, 0, 95},
    deep_sky_blue1: {0, 175, 255},
    deep_sky_blue2: {0, 175, 215},
    deep_sky_blue3: {0, 135, 175},
    deep_sky_blue4: {0, 95, 95},
    dim: 2,
    dodger_blue1: {0, 135, 255},
    dodger_blue2: {0, 95, 255},
    dodger_blue3: {0, 95, 215},
    fuchsia: {255, 0, 255},
    gold1: {255, 215, 0},
    gold3: {175, 175, 0},
    green1: {0, 255, 0},
    green3: {0, 175, 0},
    green4: {0, 135, 0},
    green: 32,
    green_yellow: {175, 255, 0},
    grey0: {0, 0, 0},
    grey100: {255, 255, 255},
    grey11: {28, 28, 28},
    grey15: {38, 38, 38},
    grey19: {48, 48, 48},
    grey23: {58, 58, 58},
    grey27: {68, 68, 68},
    grey30: {78, 78, 78},
    grey35: {88, 88, 88},
    grey37: {95, 95, 95},
    grey39: {98, 98, 98},
    grey3: {8, 8, 8},
    grey42: {108, 108, 108},
    grey46: {118, 118, 118},
    grey50: {128, 128, 128},
    grey53: {135, 135, 135},
    grey54: {138, 138, 138},
    grey58: {148, 148, 148},
    grey62: {158, 158, 158},
    grey63: {175, 135, 175},
    grey66: {168, 168, 168},
    grey69: {175, 175, 175},
    grey70: {178, 178, 178},
    grey74: {188, 188, 188},
    grey78: {198, 198, 198},
    grey7: {18, 18, 18},
    grey82: {208, 208, 208},
    grey84: {215, 215, 215},
    grey85: {218, 218, 218},
    grey89: {228, 228, 228},
    grey93: {238, 238, 238},
    grey: {128, 128, 128},
    honeydew2: {215, 255, 215},
    hot_pink2: {215, 95, 175},
    hot_pink3: {175, 95, 135},
    hot_pink: {255, 95, 175},
    indian_red1: {255, 95, 95},
    indian_red: {175, 95, 95},
    italic: 3,
    khaki1: {255, 255, 135},
    khaki3: {215, 215, 95},
    light_coral: {255, 135, 135},
    light_cyan1: {215, 255, 255},
    light_cyan3: {175, 215, 215},
    light_goldenrod1: {255, 255, 95},
    light_goldenrod2: {215, 215, 135},
    light_goldenrod3: {215, 175, 95},
    light_green: {135, 255, 95},
    light_pink1: {255, 175, 175},
    light_pink3: {215, 135, 135},
    light_pink4: {135, 95, 95},
    light_salmon1: {255, 175, 135},
    light_salmon3: {175, 135, 95},
    light_sea_green: {0, 175, 175},
    light_sky_blue1: {175, 215, 255},
    light_sky_blue3: {135, 175, 175},
    light_slate_blue: {135, 135, 255},
    light_slate_grey: {135, 135, 175},
    light_steel_blue1: {215, 215, 255},
    light_steel_blue3: {175, 175, 215},
    light_steel_blue: {175, 175, 255},
    light_yellow3: {215, 215, 175},
    lime: {0, 255, 0},
    magenta1: {255, 0, 255},
    magenta2: {215, 0, 255},
    magenta3: {175, 0, 175},
    magenta: 35,
    maroon: {128, 0, 0},
    medium_orchid1: {215, 95, 255},
    medium_orchid3: {175, 95, 175},
    medium_orchid: {175, 95, 215},
    medium_purple1: {175, 135, 255},
    medium_purple2: {175, 95, 255},
    medium_purple3: {135, 95, 175},
    medium_purple4: {95, 95, 135},
    medium_purple: {135, 135, 215},
    medium_spring_green: {0, 255, 175},
    medium_turquoise: {95, 215, 215},
    medium_violet_red: {175, 0, 135},
    misty_rose1: {255, 215, 215},
    misty_rose3: {215, 175, 175},
    navajo_white1: {255, 215, 175},
    navajo_white3: {175, 175, 135},
    navy: {0, 0, 128},
    navy_blue: {0, 0, 95},
    olive: {128, 128, 0},
    orange: {255, 128, 0},
    orange1: {255, 175, 0},
    orange3: {215, 135, 0},
    orange4: {95, 95, 0},
    orange_red1: {255, 95, 0},
    orchid1: {255, 135, 255},
    orchid2: {255, 135, 215},
    orchid: {215, 95, 215},
    pale_green1: {135, 255, 175},
    pale_green3: {95, 215, 95},
    pale_turquoise1: {175, 255, 255},
    pale_turquoise4: {95, 135, 135},
    pale_violet_red1: {255, 135, 175},
    pink1: {255, 175, 215},
    pink3: {215, 135, 175},
    plum1: {255, 175, 255},
    plum2: {215, 175, 255},
    plum3: {215, 135, 215},
    plum4: {135, 95, 135},
    purple3: {95, 0, 215},
    purple4: {95, 0, 135},
    purple: {128, 0, 128},
    red1: {255, 0, 0},
    red3: {175, 0, 0},
    red: 31,
    reset: 0,
    rosy_brown: {175, 135, 135},
    royal_blue1: {95, 95, 255},
    salmon1: {255, 135, 95},
    sandy_brown: {255, 175, 95},
    sea_green1: {95, 255, 135},
    sea_green2: {95, 255, 95},
    sea_green3: {95, 215, 135},
    silver: {192, 192, 192},
    sky_blue1: {135, 215, 255},
    sky_blue2: {135, 175, 255},
    sky_blue3: {95, 175, 215},
    slate_blue1: {135, 95, 255},
    slate_blue3: {95, 95, 175},
    spring_green1: {0, 255, 135},
    spring_green2: {0, 215, 135},
    spring_green3: {0, 175, 95},
    spring_green4: {0, 135, 95},
    steel_blue1: {95, 175, 255},
    steel_blue3: {95, 135, 215},
    steel_blue: {95, 135, 175},
    tan: {215, 175, 135},
    teal: {0, 128, 128},
    thistle1: {255, 215, 255},
    thistle3: {215, 175, 215},
    turquoise2: {0, 215, 255},
    turquoise4: {0, 135, 135},
    uline: 4,
    underline: 4,
    violet: {215, 135, 255},
    wheat1: {255, 255, 175},
    wheat4: {135, 135, 95},
    white: 37,
    yellow1: {255, 255, 0},
    yellow2: {215, 255, 0},
    yellow3: {175, 215, 0},
    yellow4: {135, 135, 0},
    yellow: 33
  }

  @doc ~S"""
  color code, potentially with a string
        
      iex(1)> color("hello", :blue)
      "\e[34mhello"

  or just the code

      iex(2)> color(:green)
      "\e[32m"

      iex(3)> color([:yellow, :bold])
      "\e[33m\e[1m"

  """
  def color(colorspec)

  def color(colorspec) when is_list(colorspec) do
    colorspec
    |> Enum.map(&_extract_code/1)
    |> Enum.join()
  end

  def color(colorspec) do
    _extract_code(colorspec)
  end

  @doc ~S"""
    Transform a string and color specifications into an IO Chardata
  """
  def color(subject, colorspec)

  def color(subject, colorspec) when is_atom(colorspec) do
    color(subject, [colorspec])
  end

  def color(subject, colorspec) do
    {cspec, suffix} = _extract_reset(colorspec)

    prefix =
      cspec
      |> Enum.map(&_extract_code/1)
      |> Enum.join()

    [prefix, subject, suffix]
    |> IO.chardata_to_string()
  end

  @doc ~S"""
  just get the code for colorspec without a string (subject)

      iex(4)> color_code(:green)
      "\e[32m"

      iex(5)> color_code([:yellow, :bold])
      "\e[33m\e[1m"

  """
  def color_code(colorspec)

  def color_code(colorspec) when is_list(colorspec) do
    colorspec
    |> Enum.map(&_extract_code/1)
    |> Enum.join()
  end

  def color_code(colorspec), do: _extract_code(colorspec)

  @doc ~S"""
  reset at the end of yje string

      iex(6)> color_reset("green", :green)
      "\e[32mgreen\e[0m"

  """
  def color_reset(subject, colorspec)

  def color_reset(subject, colorspec) when is_atom(colorspec) do
    color_reset(subject, [colorspec])
  end

  def color_reset(subject, colorspec) do
    color(subject, [:reset | colorspec])
  end

  defp _extract_code(code)

  defp _extract_code({_, _, _} = rgb) do
    if System.get_env("NO_COLOR") do
      ""
    else
      _extract_rgb(rgb)
    end
  end

  defp _extract_code(code) do
    if System.get_env("NO_COLOR") do
      ""
    else
      case Map.get(@names, code) do
        {_, _, _} = rgb -> _extract_rgb(rgb)
        {:color, col} -> _extract_col(col)
        ansi -> "\e[#{ansi}m"
      end
    end
  end

  defp _extract_col(col) do
    "\e[38;5;#{col}m"
  end

  defp _extract_rgb({r, g, b}) do
    "\e[38;2;#{r};#{g};#{b}m"
  end

  defp _extract_reset(colorspec) do
    if Enum.member?(colorspec, :reset) do
      {List.delete(colorspec, :reset), _extract_code(:reset)}
    else
      {colorspec, ""}
    end
  end
end

# SPDX-License-Identifier: AGPL-3.0-or-later
