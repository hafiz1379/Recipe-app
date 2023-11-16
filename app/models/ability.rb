class Ability
  include CanCan::Ability

  def to_hour(value)
    result = (value / 60)
    return "#{result} #{'hour'.pluralize(result)}" if value.to_i.remainder(60).zero?

    result = (value.to_i.to_f / 60).to_f
    "#{result} #{'hour'.pluralize(result)}"
  end
end
