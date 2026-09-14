/// <reference path="../pb_data/types.d.ts" />
migrate((app) => {
  const collection = app.findCollectionByNameOrId("pbc_3287756950")

  // update collection data
  unmarshal({
    "name": "item"
  }, collection)

  return app.save(collection)
}, (app) => {
  const collection = app.findCollectionByNameOrId("pbc_3287756950")

  // update collection data
  unmarshal({
    "name": "lista"
  }, collection)

  return app.save(collection)
})
