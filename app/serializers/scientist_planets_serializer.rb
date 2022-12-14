class ScientistPlanetsSerializer < ActiveModel::Serializer
    attributes :id, :field_of_study, :avatar, :name
    has_many :planets
end
