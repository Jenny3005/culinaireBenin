<?php

namespace Database\Seeders;

use App\Models\Ethnie;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;

class EthnieSeeder extends Seeder
{
    public function run(): void
    {
        $ethnies = [
            [
                'nom' => 'Fon',
                'description' => 'Groupe socio-culturel majoritaire au sud du Bénin, historiquement lié au royaume du Danxomé (Abomey).',
            ],
            [
                'nom' => 'Yoruba',
                'description' => 'Présents au sud-est et au centre, réputés pour leurs traditions artisanales et leurs croyances spirituelles.',
            ],
            [
                'nom' => 'Bariba',
                'description' => 'Groupe dominant du nord du Bénin (Borgou), reconnu pour sa tradition cavalière et la fête de la Gaani.',
            ],
            [
                'nom' => 'Adja',
                'description' => 'Installés principalement dans le département du Couffo au sud-ouest, berceau historique des peuples Aizo et Fon.',
            ],
            [
                'nom' => 'Goun',
                'description' => 'Principalement localisés dans le département de l\'Ouémé et la capitale Porto-Novo.',
            ],
            [
                'nom' => 'Dendi',
                'description' => 'Commerçants et artisans vivant le long du fleuve Niger au nord du pays (Malanville, Kandi).',
            ],
            [
                'nom' => 'Somba',
                'description' => 'Habitants de la chaîne de l\'Atacora, célèbres pour leurs tatas somba (fortesses en terre traditionnelles).',
            ],
            [
                'nom' => 'Peul',
                'description' => 'Traditionnellement éleveurs nomades et semi-nomades répartis dans la région septentrionale.',
            ],
            [
                'nom' => 'Mina',
                'description' => 'Présents le long de la côte sud-ouest, principalement dans les activités maritimes et commerciales.',
            ],
            [
                'nom' => 'Nago',
                'description' => 'Sous-groupe Yoruba localisé notamment dans le département du Plateau et des Collines.',
            ],
        ];

        foreach ($ethnies as $ethnie) {
            Ethnie::firstOrCreate(
                ['nom'=>$ethnie['nom']],
                ['description'=>$ethnie['description']]
            );
        }
    }
}