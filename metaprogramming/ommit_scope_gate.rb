# Ruby provides plenty of ways for developing things in
# object oriented fashion. Thing like omitting scope gate
# is definitely not something that you will do frequently.
# On the other hand I suppose it is better to know that this
# kind of hack is possible, even if you problably won't ever
# need to stand in front of need for using this solution.

module OmittedScopeGate
  text = %Q|This is text you will see \
         inside another lexical scope|.gsub(/\s{2,}/, ' ')

  WRAPPER = binding

  # First scope gate. This is place, where we change the
  # scope for the OmittedScopeGate singleton class. Local
  # variable 'text' won't be longer accessible here.
  class << self

    # Second scope gate. This is place where we change
    # the scope for the second time.
    def show_text_from_other_lexical_scope
      p WRAPPER.local_variable_get :text
    end
  end
end

OmittedScopeGate.show_text_from_other_lexical_scope
