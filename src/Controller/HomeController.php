<?php

namespace App\Controller;

use App\Repository\ProductoRepository; // 👈 Asegúrate de que esta línea aparezca arriba
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Attribute\Route;

final class HomeController extends AbstractController
{
    #[Route('/', name: 'app_home')]
    // 1. Añadimos el ProductoRepository dentro de los paréntesis
    public function index(ProductoRepository $productoRepository): Response
    {
        // 2. Buscamos todas las joyas guardadas en tu MySQL/PostgreSQL
        $joyas = $productoRepository->findAll();

        // 3. Le pasamos esa lista a la vista Twig bajo el nombre 'joyas'
        return $this->render('home/index.html.twig', [
            'joyas' => $joyas,
        ]);
    }
}
