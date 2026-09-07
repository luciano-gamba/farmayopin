// pb_hooks/main.pb.js

// fires only for "users" records
onRecordCreate((e) => {
    // e.app
    // e.record

    e.record.set("role", "cliente")

    e.next()
}, "users")