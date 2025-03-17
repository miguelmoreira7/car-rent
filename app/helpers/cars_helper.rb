module CarsHelper
  def generate_image_url(car, angle = '0')
    base_url = 'https://cdn.imagin.studio/getimage'

    params = {
      customer: 'hrjavascript-mastery',
      make: car.manufacturer.name,
      modelFamily: car.model.split(' ').first,
      zoomType: 'fullscreen',
      modelYear: car.year,
      angle: angle
    }

    url = "#{base_url}?#{params.to_query}"
  end
end
