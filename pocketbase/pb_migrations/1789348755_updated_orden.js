/// <reference path="../pb_data/types.d.ts" />
migrate((app) => {
  const collection = app.findCollectionByNameOrId("pbc_3954138680")

  // update collection data
  unmarshal({
    "name": "ordenes"
  }, collection)

  return app.save(collection)
}, (app) => {
  const collection = app.findCollectionByNameOrId("pbc_3954138680")

  // update collection data
  unmarshal({
    "name": "orden"
  }, collection)

  return app.save(collection)
})
