class SubjectSetSerializer < ActiveModel::MongoidSerializer

  attributes :id, :name, :thumbnail, :meta_data, :subjects, :state, :counts, :group_id

  def attributes
    data = super
    data[:pagination_info] = data[:subjects][:pagination_info]
    data[:subjects] = data[:subjects][:subjects].map {|s| SubjectSerializer.new(s, root: false)}
    data
  end

  def id
    object._id.to_s
  end

  def subjects
    workflow_id = serialization_options[:workflow_id] # I think we need to pull this from serialization_options, subject_sets don't belong to workflow.
    limit = serialization_options[:limit].to_i
    random = serialization_options[:random]

    return nil if object.nil?

    # we will have to send the page through serialization_options
    if random
      subjects = object.subjects.active_root.where(workflow_id: workflow_id).page(serialization_options[:page])      
    else
      subjects = object.subjects.active_root.where(workflow_id: workflow_id).limit(limit).page(serialization_options[:page])
    end

    subjects = {
      subjects: subjects, 
      pagination_info: 
        {
        current_page: subjects.current_page,
        next_page: subjects.next_page,
        prev_page: subjects.prev_page,
        total_pages: subjects.total_pages,
      }
    }

  end

end
