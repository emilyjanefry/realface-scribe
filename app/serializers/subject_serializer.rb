class SubjectSerializer < ActiveModel::MongoidSerializer
  attributes :id, :parent_subject_id, :workflow_id, :name, :location, :annotation_value_count, :child_subjects_info, :meta_data, :user_favourite, :key
  delegate :current_user, to: :scope

  #this seems like the place we want to control the return of subjects only if status == "active"
  
  def id
    object._id.to_s
  end

  def user_favourite
    (scope and scope.has_favourite?(object))
  end

  def child_subjects_info
    child_subjects = object.child_subjects
    child_subject_info = []
    child_subjects.each do |child|
      rebuild_info = {
        id: child.id,
        location_standard: child.location["standard"],
        spec: child.location["spec"],
        tool_type: child.tool_task_description["type"],
        label: child.tool_task_description["label"]
      }

      child_subject_info << rebuild_info
      
    end
    child_subject_info
  end

end
