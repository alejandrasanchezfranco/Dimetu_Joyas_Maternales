<?php

namespace App\DataFixtures;

use App\Entity\Producto;
use Doctrine\Bundle\FixturesBundle\Fixture;
use Doctrine\Persistence\ObjectManager;

class AppFixtures extends Fixture
{
    public function load(ObjectManager $manager): void
    {
        // Joya 1
        $joya1 = new Producto();
        $joya1->setNombre('Colgante Inicial');
        $joya1->setImagen('colgante_inicial.jpeg');
        $joya1->setPrecio(85); // 👈 ¡Añade esto! (Usa el número sin comillas)
        $manager->persist($joya1);

        // Joya 2
        $joya2 = new Producto();
        $joya2->setNombre('Colgante Nombre');
        $joya2->setImagen('colgante_nombre.jpeg');
        $joya2->setPrecio(135); // 👈 ¡Añade esto también!
        $manager->persist($joya2);

        $manager->flush();
    }
}
