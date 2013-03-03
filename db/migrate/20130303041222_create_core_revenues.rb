class CreateCoreRevenues < ActiveRecord::Migration
  def change
    ary = [[:id, "integer"], [:year, "integer"], [:core_revenues_usd, "integer"], [:tuition_et_al_pctg_core, "integer"], [:state_approp_pctg_core, "integer"], [:local_govt_approp_pctg, "integer"], [:federal_approp_pctg, "integer"], [:private_gifts_pctg_core, "integer"], [:investment_return_pctg_core, "integer"], [:other_rev_pctg_core, "integer"], [:university_id, "integer"], [:ipeds_id, "integer"], [:created_at, "datetime"], [:updated_at, "datetime"], [:ok, "boolean"]] 
    create_table :core_revenues do |t|
      ary.each do |a|
        eval("t.#{a[1]} a[0]")
      end
      t.timestamps
    end
  end
end
