class CreateCoreExpenses < ActiveRecord::Migration
  def change
    ary = [[:id, "integer"], [:year, "integer"], [:university_id, "integer"], [:ipeds_id, "integer"], [:core_expenses_usd, "integer"], [:instruction_exp_per_fte, "integer"], [:research_exp_per_fte, "integer"], [:public_service_exp_per_fte, "integer"], [:academic_support_exp_per_fte, "integer"], [:student_services_exp_per_fte, "integer"], [:institutional_support_exp_per_fte, "integer"], [:all_other_core_exp_per_fte, "integer"], [:created_at, "datetime"], [:updated_at, "datetime"], [:ok, "boolean"]]
    create_table :core_expenses do |t|
      ary.each do |a|
        eval("t.#{a[1]} a[0]")
      end
      t.timestamps
    end
  end
end
