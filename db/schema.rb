# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20150515010424) do

  create_table "articulos", force: true do |t|
    t.string   "nombre"
    t.string   "modelo"
    t.integer  "laboratorio_id"
    t.string   "numero_de_serie"
    t.string   "numero_de_inventario"
    t.string   "numero_de_sep"
    t.text     "descripcion"
    t.boolean  "disponible"
    t.text     "motivo"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "imagen_articulo_id"
  end

  add_index "articulos", ["imagen_articulo_id"], name: "index_articulos_on_imagen_articulo_id", using: :btree
  add_index "articulos", ["laboratorio_id"], name: "index_articulos_on_laboratorio_id", using: :btree

  create_table "carreras", force: true do |t|
    t.string   "nombre"
    t.integer  "departamento_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "carreras", ["departamento_id"], name: "index_carreras_on_departamento_id", using: :btree

  create_table "computadoras", force: true do |t|
    t.string   "modelo"
    t.string   "numero_serie"
    t.string   "color"
    t.integer  "tamanio"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "departamentos", force: true do |t|
    t.string   "nombre"
    t.text     "descripcion"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "imagen_articulos", force: true do |t|
    t.string   "imagen"
    t.string   "nombre_articulo"
    t.string   "modelo_articulo"
    t.integer  "laboratorio_id"
    t.string   "tipo_articulo"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "imagen_articulos", ["laboratorio_id"], name: "index_imagen_articulos_on_laboratorio_id", using: :btree

  create_table "imagen_laboratorios", force: true do |t|
    t.string   "imagen"
    t.text     "descripcion"
    t.integer  "laboratorio_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "imagen_laboratorios", ["laboratorio_id"], name: "index_imagen_laboratorios_on_laboratorio_id", using: :btree

  create_table "laboratorios", force: true do |t|
    t.string   "nombre"
    t.text     "descripcion"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "departamento_id", null: false
  end

  add_index "laboratorios", ["departamento_id"], name: "index_laboratorios_on_departamento_id", using: :btree

  create_table "materias", force: true do |t|
    t.string   "nombre"
    t.string   "clave"
    t.integer  "carrera_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "materias", ["carrera_id"], name: "index_materias_on_carrera_id", using: :btree

  create_table "prestamos", force: true do |t|
    t.integer  "usuario_prestamo_id"
    t.integer  "articulo_id"
    t.date     "fecha_de_prestamo"
    t.date     "fecha_limite"
    t.date     "fecha_de_devolucion"
    t.integer  "profesor_encargado_id"
    t.integer  "materia_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "estado"
    t.integer  "usuario_id",            null: false
  end

  add_index "prestamos", ["articulo_id"], name: "index_prestamos_on_articulo_id", using: :btree
  add_index "prestamos", ["materia_id"], name: "index_prestamos_on_materia_id", using: :btree
  add_index "prestamos", ["profesor_encargado_id"], name: "index_prestamos_on_profesor_encargado_id", using: :btree
  add_index "prestamos", ["usuario_id"], name: "index_prestamos_on_usuario_id", using: :btree
  add_index "prestamos", ["usuario_prestamo_id"], name: "index_prestamos_on_usuario_prestamo_id", using: :btree

  create_table "usuario_prestamos", force: true do |t|
    t.string   "primer_nombre"
    t.string   "segundo_nombre"
    t.string   "apellido_paterno"
    t.string   "apellido_materno"
    t.integer  "categoria"
    t.integer  "carrera_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "semestre"
    t.string   "numero_de_control"
    t.integer  "departamento_id"
    t.string   "rfc",               limit: 16
    t.boolean  "vigente"
  end

  add_index "usuario_prestamos", ["carrera_id"], name: "index_usuario_prestamos_on_carrera_id", using: :btree
  add_index "usuario_prestamos", ["departamento_id"], name: "index_usuario_prestamos_on_departamento_id", using: :btree

  create_table "usuarios", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "rol"
    t.integer  "laboratorio_id"
    t.string   "nombre"
    t.string   "apellido_paterno"
    t.string   "apellido_materno"
    t.string   "nombre_usuario"
  end

  add_index "usuarios", ["email"], name: "index_usuarios_on_email", unique: true, using: :btree
  add_index "usuarios", ["laboratorio_id"], name: "index_usuarios_on_laboratorio_id", using: :btree
  add_index "usuarios", ["reset_password_token"], name: "index_usuarios_on_reset_password_token", unique: true, using: :btree

  add_foreign_key "articulos", "imagen_articulos", name: "articulos_imagen_articulo_id_fk"
  add_foreign_key "articulos", "laboratorios", name: "articulos_laboratorio_id_fk", dependent: :delete

  add_foreign_key "carreras", "departamentos", name: "carreras_departamento_id_fk"

  add_foreign_key "imagen_laboratorios", "laboratorios", name: "imagen_laboratorios_laboratorio_id_fk", dependent: :delete

  add_foreign_key "materias", "carreras", name: "materias_carrera_id_fk"

  add_foreign_key "prestamos", "articulos", name: "prestamos_articulo_id_fk"
  add_foreign_key "prestamos", "materias", name: "prestamos_materia_id_fk"
  add_foreign_key "prestamos", "usuario_prestamos", name: "prestamos_prestamista_id_fk", dependent: :delete
  add_foreign_key "prestamos", "usuario_prestamos", name: "prestamos_profesor_encargado_id_fk", column: "profesor_encargado_id"

  add_foreign_key "usuario_prestamos", "carreras", name: "prestamistas_carrera_id_fk"

end
