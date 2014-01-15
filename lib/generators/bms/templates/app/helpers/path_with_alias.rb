# -*- encoding : utf-8 -*-
module PathWithAlias

  def my_path
    {id: self.id, alias: self.alias}
  end

  def alias
    self.title.transliterate
  end
end