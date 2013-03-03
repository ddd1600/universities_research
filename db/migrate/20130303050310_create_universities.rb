class CreateUniversities < ActiveRecord::Migration
  def change
    create_table :universities do |t|
      ary = [[:id, "integer"], [:institution_id, "integer"], [:name, "text"], [:address, "text"], [:city, "text"], [:state, "text"], [:zip, "text"], [:phone, "text"], [:institution_opeid, "text"], [:institution_ipeds_unitid, "text"], [:web_address, "text"], [:created_at, "datetime"], [:updated_at, "datetime"], [:longitude, "float"], [:latitude, "float"], [:ipeds_unit_id, "integer"], [:ope_id, "integer"], [:zip_code, "integer"], [:total_enrollment_2011, "integer"], [:total_enrollment_2003, "integer"], [:pctg_total_enrollment_change, "float"], [:c_class, "boolean"], [:b_class, "boolean"], [:a_class, "boolean"], [:cc_class, "boolean"], [:bb_class, "boolean"], [:aa_class, "boolean"], [:ccc_class, "boolean"], [:bbb_class, "boolean"], [:aaa_class, "boolean"], [:endowment_2011, "integer"], [:endowment_2010, "integer"], [:endowment_2009, "integer"], [:endowment_2008, "integer"], [:endowment_2007, "integer"], [:endowment_2006, "integer"], [:endowment_2004, "integer"], [:endowment_2000, "integer"], [:endowment_1996, "integer"], [:endowment_1991, "integer"], [:endowment_1986, "integer"], [:endowment_1980, "integer"], [:private_school, "boolean"]]
      ary.each do |a|
        eval("t.#{a[1]} a[0]")
      end

      t.timestamps
    end
  end
end