<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use App\Models\Region;

class RegionSeeder extends Seeder
{
    public function run(): void
    {
        $regions = [
            [
                'nom'         => 'Alibori',
                'description' => 'Département situé au nord-est du Bénin, réputé pour la faune du parc W et ses traditions culinaires.',
                'latitude'    => 11.200000,
                'longitude'   => 2.883333,
            ],
            [
                'nom'         => 'Atacora',
                'description' => 'Région montagneuse du nord-ouest, abritant la chaîne de l\'Atacora, la cité des Tatas Somba et des spécialités locales uniques.',
                'latitude'    => 10.300000,
                'longitude'   => 1.383333,
            ],
            [
                'nom'         => 'Atlantique',
                'description' => 'Département cotier historique bordant l\'océan, riche en culture, histoire vaudou et plats de poisson.',
                'latitude'    => 6.666667,
                'longitude'   => 2.166667,
            ],
            [
                'nom'         => 'Borgou',
                'description' => 'Grand département du nord, carrefour commercial majeur avec la ville de Parakou.',
                'latitude'    => 9.350000,
                'longitude'   => 2.616667,
            ],
            [
                'nom'         => 'Collines',
                'description' => 'Région centrale caractérisée par ses reliefs rocheux et réputée pour sa production d\'igname et d\'amandes de cajou.',
                'latitude'    => 7.916667,
                'longitude'   => 2.183333,
            ],
            [
                'nom'         => 'Couffo',
                'description' => 'Département du sud-ouest réputé pour sa riche agriculture et ses traditions artisanales.',
                'latitude'    => 7.000000,
                'longitude'   => 1.800000,
            ],
            [
                'nom'         => 'Donga',
                'description' => 'Région du nord-ouest traversée par de vastes forêts réputées pour ses tubercules et ses plats traditionnels.',
                'latitude'    => 9.700000,
                'longitude'   => 1.666667,
            ],
            [
                'nom'         => 'Littoral',
                'description' => 'Département métropolitain abritant la capitale économique Cotonou.',
                'latitude'    => 6.366667,
                'longitude'   => 2.433333,
            ],
            [
                'nom'         => 'Mono',
                'description' => 'Région côtière du sud-ouest bordée par le fleuve Mono, célèbre pour ses zones lagunaires.',
                'latitude'    => 6.633333,
                'longitude'   => 1.716667,
            ],
            [
                'nom'         => 'Ouémé',
                'description' => 'Département abritant Porto-Novo, la capitale politique, bordé par le lac Nokoué.',
                'latitude'    => 6.500000,
                'longitude'   => 2.600000,
            ],
            [
                'nom'         => 'Plateau',
                'description' => 'Département frontalier à l\'est, caractérisé par sa richesse agricole et ses échanges culturels.',
                'latitude'    => 7.166667,
                'longitude'   => 2.633333,
            ],
            [
                'nom'         => 'Zou',
                'description' => 'Cœur historique et culturel abritant la ville d\'Abomey, célèbre pour le palais royal et la gastronomie traditionnelle.',
                'latitude'    => 7.183333,
                'longitude'   => 2.066667,
            ],
        ];

        foreach ($regions as $region) {
            Region::firstOrCreate(
                ['nom' => $region['nom']], // Recherche par le nom
                [                          // Champs à remplir si la région n'existe pas
                    'description' => $region['description'],
                    'latitude'    => $region['latitude'],
                    'longitude'   => $region['longitude'],
                ]
            );
        }
    }
}