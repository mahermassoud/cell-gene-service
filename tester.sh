echo "Starting server..."
python CellGeneService.py &

# wait to load dataset before requesting
sleep 10s

# Delete all previous output so it does not effect this test run
rm output/*


# Make requests for all test cases and save output

# Test case 1: duplicates cell lines, lowercase gene and cell-line
curl -H "Content-Type: application/json" --data @input/duplicate_cell.json http://localhost:8080/context/expression/cell_line > output/duplicate_cell_out.json

# Test case 2: duplicate genes
curl -H "Content-Type: application/json" --data @input/duplicate_gene.json http://localhost:8080/context/expression/cell_line > output/duplicate_gene_out.json

# Test case 3: nonexistent gene
curl -H "Content-Type: application/json" --data @input/non_ex_gene.json http://localhost:8080/context/expression/cell_line > output/non_ex_gene_out.json

# Test case 4: nonexistent cell line
curl -H "Content-Type: application/json" --data @input/non_ex_cell.json http://localhost:8080/context/expression/cell_line > output/non_ex_cell_out.json

# Test case 5: invalid json syntax
# Test case 6: get all genes works
# Test case 7: get all cell-lines works
# Test case 8: singular inputs
# Test case 9: end up with empty set input to get_abundance or null input to get_abundance
# Test case 10: handle None output from get abundance

echo "-------------- Test case results --------------"
# Run python script to check outputs
python tester.py

# Kill server
pkill -f CellGeneService.py
