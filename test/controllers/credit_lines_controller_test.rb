require 'test_helper'

class CreditLinesControllerTest < ActionController::TestCase
  setup do
    @credit_line = credit_lines(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:credit_lines)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create credit_line" do
    assert_difference('CreditLine.count') do
      post :create, credit_line: { amount_drawn: @credit_line.amount_drawn, apr: @credit_line.apr, limit: @credit_line.limit }
    end

    assert_redirected_to credit_line_path(assigns(:credit_line))
  end

  test "should show credit_line" do
    get :show, id: @credit_line
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @credit_line
    assert_response :success
  end

  test "should update credit_line" do
    patch :update, id: @credit_line, credit_line: { amount_drawn: @credit_line.amount_drawn, apr: @credit_line.apr, limit: @credit_line.limit }
    assert_redirected_to credit_line_path(assigns(:credit_line))
  end

  test "should destroy credit_line" do
    assert_difference('CreditLine.count', -1) do
      delete :destroy, id: @credit_line
    end

    assert_redirected_to credit_lines_path
  end
end
