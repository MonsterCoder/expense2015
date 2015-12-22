class ExpensesController < ApplicationController
  before_filter :require_login
  
  def index
    rt = @current_user.expenses if @current_user
    render json: {expenses: rt}
  end
  
  def create
    expense = @current_user.expenses.create!(expense_params)
  
    if expense
      render json: {message: "expense created", expense_id: expense.id }
    else
      render json: {}, status: :badrequest
    end
  end
  
  def update
    expense = Expense.find_by_id(params[:id])
  
    if expense
      expense.update(expense_params)
      render json: {message: "expense updated", expense: expense }
    else
      render json: {}, status: :badrequest
    end

  end
  

  
  def destroy
       expense = Expense.find_by_id(params[:id])

        if expense
          expense.destroy
          render json: {message: "expense removed"}
        else
          render json: {}, status: :badrequest
        end
  end
  
  def expense_params
    params.permit(:destination, :startDate, :endDate, :amount,:comment)
  end
end
