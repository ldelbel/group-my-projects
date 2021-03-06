class ProjectsController < ApplicationController
  include SessionsHelper
  before_action :set_project, only: %i[show edit update destroy]

  def index
    @projects = if params[:type].eql?('1')
                  current_user.projects.includes(:groups).where(groups: { id: nil })
                else
                  current_user.projects
                end
  end

  def show
    @user = current_user
  end

  def new
    @project = Project.new
    @user = current_user
  end

  def edit; end

  def create
    @user = current_user
    @project = current_user.projects.new(project_params)
    unless params[:group_ids].nil?
      @groups = Group.find(params[:group_ids])
      @project.groups.push(@groups)
    end
    @project.save

    respond_to do |format|
      if @project.save
        format.html { redirect_to @project, notice: 'Project was successfully created.' }
        format.json { render :show, status: :created, location: @project }
      else
        format.html { render :new }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    if !params[:project]
      update_groups(@project, params[:group_ids])
      respond_to do |format|
        format.html { redirect_to @project, notice: 'Project was successfully updated.' }
      end
    else
      respond_to do |format|
        if @project.update(project_params)
          format.html { redirect_to @project, notice: 'Project was successfully updated.' }
          format.json { render :show, status: :ok, location: @project }
        else
          format.html { render :edit }
          format.json { render json: @project.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  def destroy
    @project.destroy
    respond_to do |format|
      format.html { redirect_to projects_url, notice: 'Project was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def set_project
    @project = Project.find(params[:id])
  end

  def project_params
    params.require(:project).permit(:name, :time_spent)
  end

  def update_groups(project, params)
    gb = project.groups.empty? ? [] : project.groups.pluck(:id).uniq
    ga = params.nil? ? [] : params.grep(/\d+/, &:to_i)
    project.groups.destroy(Group.where(id: gb - ga))
    project.groups.push(Group.where(id: ga - gb))
  end
end
