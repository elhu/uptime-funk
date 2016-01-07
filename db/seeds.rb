# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
operator = Operator.create!({
  name: 'RATP',
  city: 'Paris',
  country: 'France',
  weather_url: 'http://www.ratp.fr/meteo/ajax/data',
  content_type: 'application/json'
})

Line.create!([{
    operator_id: operator.id,
    line_type: "metro",
    name: "1",
    operator_label: "Métro 1",
    position: 1,
  }, {
    operator_id: operator.id,
    line_type: "metro",
    name: "2",
    operator_label: "Métro 2",
    position: 2,
  }, {
    operator_id: operator.id,
    line_type: "metro",
    name: "3",
    operator_label: "Métro 3",
    position: 3,
  }, {
    operator_id: operator.id,
    line_type: "metro",
    name: "3b",
    operator_label: "Métro 3b",
    position: 4,
  }, {
    operator_id: operator.id,
    line_type: "metro",
    name: "4",
    operator_label: "Métro 4",
    position: 5,
  }, {
    operator_id: operator.id,
    line_type: "metro",
    name: "5",
    operator_label: "Métro 5",
    position: 6,
  }, {
    operator_id: operator.id,
    line_type: "metro",
    name: "6",
    operator_label: "Métro 6",
    position: 7,
  }, {
    operator_id: operator.id,
    line_type: "metro",
    name: "7",
    operator_label: "Métro 7",
    position: 8,
  }, {
    operator_id: operator.id,
    line_type: "metro",
    name: "7b",
    operator_label: "Métro 7b",
    position: 9,
  }, {
    operator_id: operator.id,
    line_type: "metro",
    name: "8",
    operator_label: "Métro 8",
    position: 10,
  }, {
    operator_id: operator.id,
    line_type: "metro",
    name: "9",
    operator_label: "Métro 9",
    position: 11,
  }, {
    operator_id: operator.id,
    line_type: "metro",
    name: "10",
    operator_label: "Métro 10",
    position: 12,
  }, {
    operator_id: operator.id,
    line_type: "metro",
    name: "11",
    operator_label: "Métro 11",
    position: 13,
  }, {
    operator_id: operator.id,
    line_type: "metro",
    name: "12",
    operator_label: "Métro 12",
    position: 14,
  }, {
    operator_id: operator.id,
    line_type: "metro",
    name: "13",
    operator_label: "Métro 13",
    position: 15,
  }, {
    operator_id: operator.id,
    line_type: "metro",
    name: "14",
    operator_label: "Métro 14",
    position: 16,
  }, {
    operator_id: operator.id,
    line_type: "rer",
    name: "A",
    operator_label: "RER A",
    position: 1,
  }, {
    operator_id: operator.id,
    line_type: "rer",
    name: "B",
    operator_label: "RER B",
    position: 2,
  }, {
    operator_id: operator.id,
    line_type: "tram",
    name: "T1",
    operator_label: "Tramway T1",
    position: 1,
  }, {
    operator_id: operator.id,
    line_type: "tram",
    name: "T2",
    operator_label: "Tramway T2",
    position: 2,
  }, {
    operator_id: operator.id,
    line_type: "tram",
    name: "T3a",
    operator_label: "Tramway T3a",
    position: 3,
  }, {
    operator_id: operator.id,
    line_type: "tram",
    name: "T3b",
    operator_label: "Tramway T3b",
    position: 4,
  }, {
    operator_id: operator.id,
    line_type: "tram",
    name: "T5",
    operator_label: "Tramway T5",
    position: 6,
  }, {
    operator_id: operator.id,
    line_type: "tram",
    name: "T6",
    operator_label: "Tramway T6",
    position: 7,
  }, {
    operator_id: operator.id,
    line_type: "tram",
    name: "T7",
    operator_label: "Tramway T7",
    position: 8,
  }, {
    operator_id: operator.id,
    line_type: "tram",
    name: "T8",
    operator_label: "Tramway T8",
    position: 9,
  }
])
