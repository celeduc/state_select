module ActionView::Helpers::FormOptionsHelper
  
  # Return select and option tags for the given object and method, using state_options_for_select to generate the list of option tags.
  def state_select(object, method, country='US', options = {}, html_options = {})
    ActionView::Helpers::InstanceTag.new(object, method, self, nil, options.delete(:object)).to_state_select_tag(country, options, html_options)
  end
  
  # Returns a string of option tags for states in a country. Supply a state name as +selected+ to
  # have it marked as the selected option tag. 
  #
  # NOTE: Only the option tags are returned, you have to wrap this call in a regular HTML select tag.
  
  def state_options_for_select(selected = nil, country = 'US')
    state_options = ""
    if country
      state_options += options_for_select(eval(country+'_STATES'), selected)
    end
    return state_options
  end
  
  private
  
  US_STATES=["Alaska", "Alabama", "Arkansas", "Arizona", "California", "Colorado", "Connecticut", "Washington D.C.", "Delaware", "Florida", "Georgia", "Hawaii", "Iowa", "Idaho", "Illinois", "Indiana", "Kansas", "Kentucky", "Louisiana", "Massachusetts", "Maryland", "Maine", "Michigan", "Minnesota", "Missourri", "Mississippi", "Montana", "North Carolina", "North Dakota", "Nebraska", "New Hampshire", "New Jersey", "New Mexico", "Nevada", "New York", "Ohio", "Oklahoma", "Oregon", "Pennsylvania", "Puerto Rico", "Rhode Island", "South Carolina", "South Dakota", "Tennessee", "Texas", "Utah", "Virginia", "Vermont", "Washington", "Wisconsin", "West Virginia", "Wyoming"] unless const_defined?("US_STATES")
  INDIA_STATES=["Andhra Pradesh",  "Arunachal Pradesh",  "Assam", "Bihar", "Chhattisgarh", "New Delhi", "Goa", "Gujarat", "Haryana", "Himachal Pradesh", "Jammu and Kashmir", "Jharkhand", "Karnataka", "Kerala", "Madhya Pradesh", "Maharashtra", "Manipur", "Meghalaya", "Mizoram", "Nagaland", "Orissa""Punjab", "Rajasthan", "Sikkim", "Tamil Nadu", "Tripura", "Uttaranchal", "Uttar Pradesh", "West Bengal"] unless const_defined?("INDIA_STATES")      
  CANADA_STATES=["Alberta", "British Columbia", "District of Columbia", "Manitoba", "New Brunswick", "Newfoundland and Labrador", "Northwest Territories", "Nova Scotia", "Nunavut", "Prince Edward Island", "Saskatchewan", "Ontario", "Quebec"] unless const_defined?("CANADA_STATES")      
end

class ActionView::Helpers::InstanceTag
  
  
  def to_state_select_tag(country, options, html_options)
    html_options = html_options.stringify_keys
    add_default_name_and_id(html_options)
    selected_value = options.has_key?(:selected) ? options[:selected] : value
    content_tag("select", add_options(state_options_for_select(selected_value, country), options, value), html_options)
  end
end


class ActionView::Helpers::FormBuilder
  def state_select(method, country = 'US', options = {}, html_options = {})
    @template.state_select(@object_name, method, country, options.merge(:object => @object), html_options)
  end
end 

