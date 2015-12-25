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
    name: "2",
    operator_label: "Métro 2"
  }, {
    operator_id: operator.id,
    line_type: "rer",
    name: "B",
    operator_label: "RER B"
  }, {
    operator_id: operator.id,
    line_type: "tramway",
    name: "T3a",
    operator_label: "Tramway T3a"
  }, {
    operator_id: operator.id,
    line_type: "metro",
    name: "10",
    operator_label: "Métro 10"
  }, {
    operator_id: operator.id,
    line_type: "metro",
    name: "13",
    operator_label: "Métro 13"
  }, {
    operator_id: operator.id,
    line_type: "metro",
    name: "3",
    operator_label: "Métro 3"
  }, {
    operator_id: operator.id,
    line_type: "metro",
    name: "14",
    operator_label: "Métro 14"
  }, {
    operator_id: operator.id,
    line_type: "tramway",
    name: "T8",
    operator_label: "Tramway T8"
  }, {
    operator_id: operator.id,
    line_type: "metro",
    name: "6",
    operator_label: "Métro 6"
  }, {
    operator_id: operator.id,
    line_type: "metro",
    name: "8",
    operator_label: "Métro 8"
  }, {
    operator_id: operator.id,
    line_type: "metro",
    name: "1",
    operator_label: "Métro 1"
  }, {
    operator_id: operator.id,
    line_type: "tramway",
    name: "T1",
    operator_label: "Tramway T1"
  }, {
    operator_id: operator.id,
    line_type: "metro",
    name: "3b",
    operator_label: "Métro 3b"
  }, {
    operator_id: operator.id,
    line_type: "metro",
    name: "5",
    operator_label: "Métro 5"
  }, {
    operator_id: operator.id,
    line_type: "tramway",
    name: "T5",
    operator_label: "Tramway T5"
  }, {
    operator_id: operator.id,
    line_type: "metro",
    name: "9",
    operator_label: "Métro 9"
  }, {
    operator_id: operator.id,
    line_type: "metro",
    name: "12",
    operator_label: "Métro 12"
  }, {
    operator_id: operator.id,
    line_type: "metro",
    name: "7b",
    operator_label: "Métro 7b"
  }, {
    operator_id: operator.id,
    line_type: "tramway",
    name: "T3b",
    operator_label: "Tramway T3b"
  }, {
    operator_id: operator.id,
    line_type: "tramway",
    name: "T6",
    operator_label: "Tramway T6"
  }, {
    operator_id: operator.id,
    line_type: "metro",
    name: "11",
    operator_label: "Métro 11"
  }, {
    operator_id: operator.id,
    line_type: "metro",
    name: "7",
    operator_label: "Métro 7"
  }, {
    operator_id: operator.id,
    line_type: "tramway",
    name: "T7",
    operator_label: "Tramway T7"
  }, {
    operator_id: operator.id,
    line_type: "metro",
    name: "4",
    operator_label: "Métro 4"
  }, {
    operator_id: operator.id,
    line_type: "tramway",
    name: "T2",
    operator_label: "Tramway T2"
  }, {
    operator_id: operator.id,
    line_type: "rer",
    name: "A",
    operator_label: "RER A"}])
