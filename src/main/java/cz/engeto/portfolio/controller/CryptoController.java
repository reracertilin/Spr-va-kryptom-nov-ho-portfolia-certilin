package cz.engeto.portfolio.controller;

import cz.engeto.portfolio.model.Crypto;
import cz.engeto.portfolio.service.CryptoService;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/cryptos")
public class CryptoController {

    private final CryptoService cryptoService;

    public CryptoController(CryptoService cryptoService) {
        this.cryptoService = cryptoService;
    }

    @PostMapping
    public ResponseEntity<Crypto> addCrypto(@RequestBody Crypto crypto) {
        Crypto created = cryptoService.addCrypto(crypto);
        return ResponseEntity.status(HttpStatus.CREATED).body(created);
    }

    @GetMapping
    public List<Crypto> getAllCryptos(@RequestParam(required = false) String sort) {
        return cryptoService.getAllCryptos(sort);
    }

    @GetMapping("/{id}")
    public ResponseEntity<Crypto> getCryptoById(@PathVariable int id) {
        return cryptoService.findById(id)
                .map(ResponseEntity::ok)
                .orElse(ResponseEntity.notFound().build());
    }

    @PutMapping("/{id}")
    public ResponseEntity<Crypto> updateCrypto(@PathVariable int id, @RequestBody Crypto crypto) {
        return cryptoService.updateCrypto(id, crypto)
                .map(ResponseEntity::ok)
                .orElse(ResponseEntity.notFound().build());
    }

    @GetMapping("/portfolio-value")
    public double getPortfolioValue() {
        return cryptoService.calculatePortfolioValue();
    }
}
