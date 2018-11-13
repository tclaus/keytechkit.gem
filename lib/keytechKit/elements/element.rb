
module KeytechKit
  ##
  # Represents a single element
  class Element
    attr_accessor :key # unique key of this element
    attr_accessor :name

    # a array of {key:, value:} pairs
    attr_accessor :keyValueList

    attr_accessor :createdByLong
    attr_accessor :createdBy
    attr_accessor :createdAt

    attr_accessor :changedAt
    attr_accessor :changedByLong
    attr_accessor :changedBy

    attr_accessor :displayname # localized DisplayName
    attr_accessor :thumbnailHint
    attr_accessor :hasVersions
    attr_accessor :classDisplayName
    attr_accessor :status
    attr_accessor :version
    attr_accessor :description

    def initialize(data)
      @key = data['Key']
      @name = data['Name']
      set_key_value_list(data['KeyValueList'])


      @classDisplayName = data['ClassDisplayName']
      @version = data['Version']
      @status = data['Status']
      @description = data['Description']

      @changedBy = data['ChangedBy']
      @changedByLong = data['ChangedByLong']
      @changedAt = data['ChangedAt']

      @createdBy = data['CreatedBy']
      @createdByLong = data['CreatedByLong']
      @createdAt = data['CreatedAt']

      @thumbnailHint = data['ThumbnailHint']
      @hasVersions = data['HasVersions']

      class_key = Tools.class_key(@key)
      project_classes = %w[TASK_WF MAIL_WF]
      @displayname = if project_classes.include?(class_key)
                       data['Subject']
                     else
                       data['DisplayName']
                     end
    end

    def to_hash
      { Key: key, Name: name, keyValueList: keytechKeyValueObject }
    end

    # This is keytech - Style: key and value in different elements-
    # No easy parsable hash!
    # Sorry  it was me. I was young and needed the money ;-)
    #  {
    #   "Key": "au_do__categorylocalized",
    #   "Value": "Blaue Kategorie"
    # }
    def keytechKeyValueObject
      arrayOfKeyValuePairs = []
      keyValueList.each do |key, value|
        arrayOfKeyValuePairs.push ({ Key: key, Value: value })
      end
      arrayOfKeyValuePairs
    end

    private

    def set_key_value_list(kv_data)
      @keyValueList = ({})
      if kv_data
        kv_data.each do |kvPair|
          keyValueList[kvPair['Key'].to_s] = kvPair['Value']
        end
      end
    end
  end
end
