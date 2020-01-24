<?php

namespace App\Command;

use App\Elasticsearch\ArticleIndexer;
use App\Elasticsearch\IndexBuilder;
use Symfony\Component\Console\Command\Command;
use Symfony\Component\Console\Input\InputInterface;
use Symfony\Component\Console\Output\OutputInterface;
use Symfony\Component\Console\Style\SymfonyStyle;

class ElasticReindexCommand extends Command
{
    protected static $defaultName = 'elastic:reindex';

    private $indexBuilder;
    private $articleIndexer;

    public function __construct(IndexBuilder $indexBuilder, ArticleIndexer $articleIndexer)
    {
        $this->indexBuilder = $indexBuilder;
        $this->articleIndexer = $articleIndexer;

        parent::__construct();
    }

    protected function configure()
    {
        $this
            ->setDescription('Rebuild the Index and populate it.')
        ;
    }

    protected function execute(InputInterface $input, OutputInterface $output)
    {
        $io = new SymfonyStyle($input, $output);

        $index = $this->indexBuilder->create();

        $io->success('Index created!');

        $this->articleIndexer->indexAllDocuments($index->getName());

        $io->success('Index populated and ready!');
    }
}