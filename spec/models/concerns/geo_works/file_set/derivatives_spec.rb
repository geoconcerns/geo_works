require 'spec_helper'

shared_examples 'a set of raster derivatives' do
  let(:generator) { instance_double(GeoWorks::EventsGenerator) }
  before do
    allow(GeoWorks::EventsGenerator).to receive(:new).and_return(generator)
    allow(generator).to receive(:derivatives_created)
  end
  it 'makes a thumbnail' do
    new_thumb = "#{Rails.root}/tmp/derivatives/#{file_set.id}/thumbnail.thumbnail"
    expect(generator).to receive(:derivatives_created).with(file_set)
    expect {
      file_set.create_derivatives(file_name)
    }.to change { Dir[new_thumb].empty? }
      .from(true).to(false)
  end

  it 'makes a display raster' do
    new_thumb = "#{Rails.root}/tmp/derivatives/#{file_set.id}/display_raster.display_raster"
    expect {
      file_set.create_derivatives(file_name)
    }.to change { Dir[new_thumb].empty? }
      .from(true).to(false)
  end
end

shared_examples 'a set of vector derivatives' do
  let(:generator) { instance_double(GeoWorks::EventsGenerator) }
  let(:geometry_service) { instance_double(GeoWorks::VectorGeometryService) }

  before do
    allow(GeoWorks::EventsGenerator).to receive(:new).and_return(generator)
    allow(GeoWorks::VectorGeometryService).to receive(:new).and_return(geometry_service)
    allow(generator).to receive(:derivatives_created)
  end
  it 'makes a thumbnail' do
    new_thumb = "#{Rails.root}/tmp/derivatives/#{file_set.id}/thumbnail.thumbnail"
    expect(generator).to receive(:derivatives_created).with(file_set)
    expect(geometry_service).to receive(:call)
    expect {
      file_set.create_derivatives(file_name)
    }.to change { Dir[new_thumb].empty? }
      .from(true).to(false)
  end

  it 'makes a display vector' do
    new_thumb = "#{Rails.root}/tmp/derivatives/#{file_set.id}/display_vector.display_vector"
    expect(geometry_service).to receive(:call)
    expect {
      file_set.create_derivatives(file_name)
    }.to change { Dir[new_thumb].empty? }
      .from(true).to(false)
  end
end

describe Hyrax::FileSet do
  let(:file_set) { FileSet.create { |gf| gf.apply_depositor_metadata('geonerd@example.com') } }

  before do
    allow(file_set).to receive(:geo_mime_type).and_return(geo_mime_type)

    allow(Hyrax::DerivativePath).to receive(:derivative_path_for_reference) do |object, key|
      "#{Rails.root}/tmp/derivatives/#{object.id}/#{key}.#{key}"
    end
  end

  after do
    dir = File.join(Hyrax.config.derivatives_path, file_set.id)
    FileUtils.rm_r(dir) if File.directory?(dir)
  end

  describe 'geo derivatives' do
    describe 'vector processing' do
      context 'with a shapefile' do
        let(:geo_mime_type) { 'application/zip; ogr-format="ESRI Shapefile"' }
        let(:file_name) { File.join(fixture_path, 'files', 'tufts-cambridgegrid100-04.zip') }
        it_behaves_like 'a set of vector derivatives'
      end

      context 'with a geojson file' do
        let(:geo_mime_type) { 'application/vnd.geo+json' }
        let(:file_name) { File.join(fixture_path, 'files', 'mercer.json') }
        it_behaves_like 'a set of vector derivatives'
      end
    end

    describe 'raster processing' do
      context 'with a geo tiff file' do
        let(:geo_mime_type) { 'image/tiff; gdal-format=GTiff' }
        let(:file_name) { File.join(fixture_path, 'files', 'S_566_1914_clip.tif') }
        it_behaves_like 'a set of raster derivatives'
      end

      context 'with a usgs ascii dem file' do
        let(:geo_mime_type) { 'text/plain; gdal-format=USGSDEM' }
        let(:file_name) { File.join(fixture_path, 'files', 'shandaken_clip.dem') }
        it_behaves_like 'a set of raster derivatives'
      end

      context 'with an arc/info binary grid file' do
        let(:geo_mime_type) { 'application/octet-stream; gdal-format=AIG' }
        let(:file_name) { File.join(fixture_path, 'files', 'precipitation.zip') }
        it_behaves_like 'a set of raster derivatives'
      end
    end
  end
end
