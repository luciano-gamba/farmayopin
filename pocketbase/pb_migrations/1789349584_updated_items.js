/// <reference path="../pb_data/types.d.ts" />
migrate((app) => {
  const collection = app.findCollectionByNameOrId("pbc_3287756950")

  // update field
  collection.fields.addAt(2, new Field({
    "cascadeDelete": false,
    "collectionId": "pbc_3954138680",
    "help": "",
    "hidden": false,
    "id": "relation3191716615",
    "maxSelect": 0,
    "minSelect": 0,
    "name": "miOrden",
    "presentable": false,
    "required": true,
    "system": false,
    "type": "relation"
  }))

  return app.save(collection)
}, (app) => {
  const collection = app.findCollectionByNameOrId("pbc_3287756950")

  // update field
  collection.fields.addAt(2, new Field({
    "cascadeDelete": false,
    "collectionId": "pbc_3954138680",
    "help": "",
    "hidden": false,
    "id": "relation3191716615",
    "maxSelect": 0,
    "minSelect": 0,
    "name": "miOrden",
    "presentable": false,
    "required": false,
    "system": false,
    "type": "relation"
  }))

  return app.save(collection)
})
