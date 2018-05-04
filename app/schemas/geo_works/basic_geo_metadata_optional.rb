module GeoWorks
  class BasicGeoMetadataOptional < ActiveTriples::Schema
    #
    # The following properties are inherited from Hyrax's metadata
    # @see https://github.com/samvera/hyrax/blob/v2.0.2/app/models/concerns/hyrax/basic_metadata.rb
    #
    # Optional:
    #   :contributor
    #   :creator
    #   :date_created (DC.created)
    #   :description
    #   :identifier
    #   :language
    #   :license
    #   :publisher
    #   :resource_type (DC.type)
    #   :rights_statement
    #   :source
    #   :subject
    #   :tag (DC11.relation)
    #

    # Defines the placenames related to the layer
    # @example
    #   image.spatial = [ 'France', 'Spain' ]
    property :spatial, predicate: ::RDF::Vocab::DC.spatial

    # Defines the temporal coverage of the layer
    # @example
    #   vector.temporal = [ '1998-2006', 'circa 2000' ]
    property :temporal, predicate: ::RDF::Vocab::DC.temporal

    # Defines the issued date for the layer, using XML Schema dateTime format
    #   (YYYY-MM-DDThh:mm:ssZ).
    # @example
    #   vector.issued = '2001-01-01T00:00:00Z'
    property :issued, predicate: ::RDF::Vocab::DC.issued, multiple: false
  end
end
