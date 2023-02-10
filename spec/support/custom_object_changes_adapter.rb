# frozen_string_literal: true

# This custom serializer excludes nil values
class CustomObjectChangesAdapter
  def diff(changes)
    changes
  end

  def load_changeset(version)
    version.changeset
  end

  def where_attribute_changes(klass, attribute)
    klass.where(attribute)
  end

  def where_object_changes(klass, attributes)
    klass.where(attributes)
  end

  def where_object_changes_from(klass, attributes)
    klass.where(attributes)
  end

  def where_object_changes_to(klass, attributes)
    klass.where(attributes)
  end
end
