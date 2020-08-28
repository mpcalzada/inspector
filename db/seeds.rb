# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

AccountType.create(id: 1, name: 'Tarjeta de Crédito', description: 'Tarjeta de crédito')
AccountType.create(id: 2, name: 'Tarjeta de Debito', description: 'Tarjeta de Debito')
AccountType.create(id: 3, name: 'Cheque', description: 'Cuenta de chequera')
