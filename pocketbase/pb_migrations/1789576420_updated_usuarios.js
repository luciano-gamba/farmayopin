/// <reference path="../pb_data/types.d.ts" />
migrate((app) => {
  const collection = app.findCollectionByNameOrId("_pb_users_auth_")

  // update field
  collection.fields.addAt(9, new Field({
    "cascadeDelete": false,
    "collectionId": "pbc_3954138680",
    "help": "",
    "hidden": false,
    "id": "relation2673399094",
    "maxSelect": 10,
    "minSelect": 0,
    "name": "misOrdenes",
    "presentable": false,
    "required": false,
    "system": false,
    "type": "relation"
  }))

  return app.save(collection)
}, (app) => {
  const collection = app.findCollectionByNameOrId("_pb_users_auth_")

  // update field
  collection.fields.addAt(9, new Field({
    "cascadeDelete": false,
    "collectionId": "pbc_3954138680",
    "help": "",
    "hidden": false,
    "id": "relation2673399094",
    "maxSelect": 10,
    "minSelect": 0,
    "name": "miHistorial",
    "presentable": false,
    "required": false,
    "system": false,
    "type": "relation"
  }))

  return app.save(collection)
})
