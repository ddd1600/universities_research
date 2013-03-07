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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130307033834) do

  create_table "colleges", :force => true do |t|
    t.integer  "year"
    t.integer  "ipeds_id"
    t.integer  "college_id"
    t.integer  "total_dormroom_capacity"
    t.integer  "avg_room_cost_per_year"
    t.datetime "created_at",              :null => false
    t.datetime "updated_at",              :null => false
    t.boolean  "ok"
  end

  create_table "core_expenses", :force => true do |t|
    t.integer  "year"
    t.integer  "university_id"
    t.integer  "ipeds_id"
    t.integer  "core_expenses_usd"
    t.integer  "instruction_exp_per_fte"
    t.integer  "research_exp_per_fte"
    t.integer  "public_service_exp_per_fte"
    t.integer  "academic_support_exp_per_fte"
    t.integer  "student_services_exp_per_fte"
    t.integer  "institutional_support_exp_per_fte"
    t.integer  "all_other_core_exp_per_fte"
    t.datetime "created_at",                        :null => false
    t.datetime "updated_at",                        :null => false
    t.boolean  "ok"
  end

  create_table "core_revenues", :force => true do |t|
    t.integer  "year"
    t.integer  "core_revenues_usd"
    t.integer  "tuition_et_al_pctg_core"
    t.integer  "state_approp_pctg_core"
    t.integer  "local_govt_approp_pctg"
    t.integer  "federal_approp_pctg"
    t.integer  "private_gifts_pctg_core"
    t.integer  "investment_return_pctg_core"
    t.integer  "other_rev_pctg_core"
    t.integer  "university_id"
    t.integer  "ipeds_id"
    t.datetime "created_at",                  :null => false
    t.datetime "updated_at",                  :null => false
    t.boolean  "ok"
  end

  create_table "freshman_stats", :force => true do |t|
    t.integer  "year"
    t.integer  "ipeds_id"
    t.integer  "university_id"
    t.integer  "freshmen_entering"
    t.integer  "total_entering_undergrads"
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
    t.boolean  "ok"
  end

  create_table "interests", :force => true do |t|
    t.integer  "user_id"
    t.integer  "university_id"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "interests", ["university_id"], :name => "index_interests_on_university_id"
  add_index "interests", ["user_id"], :name => "index_interests_on_user_id"

  create_table "room_and_boards", :force => true do |t|
    t.integer  "year"
    t.integer  "ipeds_id"
    t.integer  "university_id"
    t.integer  "total_dormroom_capacity"
    t.integer  "avg_room_cost_per_year"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "ok"
    t.integer  "freshmen_entering"
    t.integer  "total_entering_undergrads"
    t.integer  "dorm_capacity_minus_entering_freshman_class_size"
    t.integer  "entering_freshman_class_minus_dorm_capacity"
    t.integer  "dorm_capacity_minus_total_entering_undergrads"
    t.integer  "total_entering_undergrads_minus_dorm_capacity"
  end

  create_table "universities", :force => true do |t|
    t.integer  "institution_id"
    t.text     "name"
    t.text     "address"
    t.text     "city"
    t.text     "state"
    t.text     "zip"
    t.text     "phone"
    t.text     "institution_opeid"
    t.text     "institution_ipeds_unitid"
    t.text     "web_address"
    t.datetime "created_at",                          :null => false
    t.datetime "updated_at",                          :null => false
    t.float    "longitude"
    t.float    "latitude"
    t.integer  "ipeds_unit_id"
    t.integer  "ope_id"
    t.integer  "zip_code"
    t.integer  "total_enrollment_2011"
    t.integer  "total_enrollment_2003"
    t.float    "pctg_total_enrollment_change"
    t.boolean  "c_class"
    t.boolean  "b_class"
    t.boolean  "a_class"
    t.boolean  "cc_class"
    t.boolean  "bb_class"
    t.boolean  "aa_class"
    t.boolean  "ccc_class"
    t.boolean  "bbb_class"
    t.boolean  "aaa_class"
    t.integer  "endowment_2011"
    t.integer  "endowment_2010"
    t.integer  "endowment_2009"
    t.integer  "endowment_2008"
    t.integer  "endowment_2007"
    t.integer  "endowment_2006"
    t.integer  "endowment_2004"
    t.integer  "endowment_2000"
    t.integer  "endowment_1996"
    t.integer  "endowment_1991"
    t.integer  "endowment_1986"
    t.integer  "endowment_1980"
    t.boolean  "private_school"
    t.integer  "latest_endowment_number"
    t.integer  "revenues_pctg_tuition_2011"
    t.integer  "revenues_pctg_federal_aid_2011"
    t.integer  "revenues_pctg_inv_return_2011"
    t.integer  "revenues_pctg_priv_gifts_2011"
    t.decimal  "revenues_2011"
    t.integer  "instruction_exp_person_2011"
    t.integer  "research_exp_per_person_2011"
    t.integer  "revenues_pctg_state_funding_2011"
    t.integer  "revenues_pctg_substate_funding_2011"
    t.integer  "freshmen_entering_latest_available"
  end

  create_table "users", :force => true do |t|
    t.string   "email"
    t.string   "name"
    t.string   "password_digest"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

end
