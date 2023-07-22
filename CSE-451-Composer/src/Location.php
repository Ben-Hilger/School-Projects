<?php 

/*
 * (c) Kyle Lierer <liererkt@miamioh.edu>
 *
 * This source file is subject to the MIT license that is bundled
 * with this source code in the file LICENSE.
 */

namespace Hilgerbj\OpenWeatherClient;

/**
 * Represents an OpenWeather location.
 */
class Location
{
    private $city;
    private $state;
    private $country;

    /**
     * Creates a new Location.
     */
    public function __construct($city, $state, $country)
    {
        $this->city = $city;
        $this->state = $state;
        $this->country = $country;
    }

    /**
     * Returns the city.
     */
    public function getCity()
    {
        return $this->city;
    }

    /**
     * Returns the state.
     */
    public function getState()
    {
        return $this->state;
    }

    /**
     * Returns the country.
     */
    public function getCountry()
    {
        return $this->country;
    }
}
