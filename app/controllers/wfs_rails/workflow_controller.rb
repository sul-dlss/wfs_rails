module WfsRails
  ##
  # API for handling workflow request
  class WorkflowController < ApplicationController
    def lifecycle
      @objects = Workflow.where(
        repository: params[:repo], druid: params[:druid]
      )
    end

    def workflows
      @processes = Workflow.where(
        repository: params[:repo], druid: params[:druid]
      ).order(:datastream, created_at: :asc).group_by(&:datastream)
    end

    def workflows_by_datastream
      @processes = Workflow.where(
        repository: params[:repo],
        druid: params[:druid],
        datastream: params[:workflow]
      ).order(:datastream, created_at: :asc).group_by(&:datastream)
      render :workflows
    end
  end
end
