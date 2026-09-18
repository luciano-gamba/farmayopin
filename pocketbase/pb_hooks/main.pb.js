// pb_hooks/main.pb.js

// fires only for "users" records
onRecordCreate((e) => {
    // e.app
    // e.record

    e.record.set("role", "cliente")
    e.record.set("emailVisibility", true)

    e.next()
}, "usuarios")