module OmittedScopeGate
  text = %Q|This is text you will see \
         inside another lexical scope|.gsub(/\s{2,}/, ' ')

  WRAPPER = binding

  class << self
    def show_text_from_other_lexical_scope
      p WRAPPER.local_variable_get :text
    end
  end
end

OmittedScopeGate.show_text_from_other_lexical_scope
