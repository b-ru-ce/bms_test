# -*- encoding : utf-8 -*-
module ApplicationHelper
  def transliterate(str)
    new_str = ""

    hash = {
        "а" => "a",
        "б" => "b",
        "в" => "v",
        "г" => "g",
        "д" => "d",
        "е" => "e",
        "ё" => "yo",
        "ж" => "zh",
        "з" => "z",
        "и" => "i",
        "й" => "j",
        "к" => "k",
        'л' => "l",
        "м" => "m",
        "н" => "n",
        "о" => "o",
        "п" => "p",
        "р" => "r",
        "с" => "s",
        "т" => "t",
        "у" => "u",
        "ф" => "f",
        "х" => "h",
        "ц" => "c",
        "ч" => "ch",
        "ш" => "sh",
        "щ" => "shh",
        "ь" => "",
        "ы" => "y",
        "ъ" => "",
        "э" => "eh",
        "ю" => "ju",
        "я" => "ja",
        "А" => "a",
        "Б" => "b",
        "В" => "v",
        "Г" => "g",
        "Д" => "d",
        "Е" => "e",
        "Ё" => "yo",
        "Ж" => "zh",
        "З" => "z",
        "И" => "i",
        "Й" => "j",
        "К" => "k",
        'Л' => "l",
        "М" => "m",
        "Н" => "n",
        "О" => "o",
        "П" => "p",
        "Р" => "r",
        "С" => "s",
        "Т" => "t",
        "У" => "u",
        "Ф" => "f",
        "Х" => "h",
        "Ц" => "c",
        "Ч" => "ch",
        "Ш" => "sh",
        "Щ" => "shh",
        "Ь" => "",
        "Ы" => "y",
        "Ъ" => "",
        "Э" => "eh",
        "Ю" => "ju",
        "Я" => "ja",
    }

    str.each_char do |my_symbol|
      if my_symbol =~ /[а-яА-Я]+/
        new_str += hash[my_symbol]
      elsif my_symbol =~ /[^a-zA-Z0-9_]+/
        new_str += "-"
      else new_str += my_symbol
      end
    end

    new_str = new_str.downcase.gsub(/-{2,}/, "-").gsub(/^-|-$/, "")
  end


  def html_title(page_title = '')
    if page_title.strip.blank?
      content_for :html_title, (MyConfig.get_config 'default_title')
    else
      content_for :html_title, page_title.to_s
    end

  end


  def html_meta(page_meta)
    content_for :html_meta, page_meta.to_s
  end

end
