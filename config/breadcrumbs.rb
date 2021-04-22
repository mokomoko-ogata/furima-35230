crumb :root do
  link "Home", root_path
end

crumb :cards do
  link "カード登録", cards_new_path
  parent :items
end

crumb :items do
  link "商品詳細ページ", item_path
  parent :root
end

crumb :new do
  link "商品出品ページ", new_item_path
  parent :root
end

crumb :edit do
  link "商品編集ページ", edit_item_path
  parent :items
end

crumb :purchases do
  link "商品購入ページ", item_purchases_path
  parent :items
end

crumb :search do
  link "商品詳細検索", items_search_path
  parent :root
end

crumb :sign_up do
  link "新規ユーザー登録", new_user_registration_path
  parent :root
end

crumb :sign_in do
  link "サインインページ", new_user_session_path
  parent :root
end

# crumb :projects do
#   link "Projects", projects_path
# end

# crumb :project do |project|
#   link project.name, project_path(project)
#   parent :projects
# end

# crumb :project_issues do |project|
#   link "Issues", project_issues_path(project)
#   parent :project, project
# end

# crumb :issue do |issue|
#   link issue.title, issue_path(issue)
#   parent :project_issues, issue.project
# end

# If you want to split your breadcrumbs configuration over multiple files, you
# can create a folder named `config/breadcrumbs` and put your configuration
# files there. All *.rb files (e.g. `frontend.rb` or `products.rb`) in that
# folder are loaded and reloaded automatically when you change them, just like
# this file (`config/breadcrumbs.rb`).