/// <reference path="../pb_data/types.d.ts" />
migrate((app) => {
  const collection = app.findCollectionByNameOrId("pbc_3954138680")

  // update field
  collection.fields.addAt(4, new Field({
    "cascadeDelete": false,
    "collectionId": "pbc_3287756950",
    "help": "",
    "hidden": false,
    "id": "relation2760546877",
    "maxSelect": 10,
    "minSelect": 0,
    "name": "misItems",
    "presentable": false,
    "required": false,
    "system": false,
    "type": "relation"
  }))

  return app.save(collection)
}, (app) => {
  const collection = app.findCollectionByNameOrId("pbc_3954138680")

  // update field
  collection.fields.addAt(4, new Field({
    "cascadeDelete": false,
    "collectionId": "pbc_3287756950",
    "help": "",
    "hidden": false,
    "id": "relation2760546877",
    "maxSelect": 10,
    "minSelect": 0,
    "name": "miLista",
    "presentable": false,
    "required": false,
    "system": false,
    "type": "relation"
  }))

  return app.save(collection)
})
