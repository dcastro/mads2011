class AddStatusAndErrorMsgToSuggestionSteps < ActiveRecord::Migration
  def change
    add_column :suggestion_steps, :status, :string
    add_column :suggestion_steps, :error_msg, :text
  end
end
