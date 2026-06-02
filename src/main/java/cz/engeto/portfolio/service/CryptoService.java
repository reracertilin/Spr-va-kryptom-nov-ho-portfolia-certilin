package cz.engeto.portfolio.service;

import cz.engeto.portfolio.model.Crypto;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.Comparator;
import java.util.List;
import java.util.Map;
import java.util.Optional;

@Service
public class CryptoService {

    private final List<Crypto> portfolio = new ArrayList<>();
    private int nextId = 1;

    private static final Map<String, Comparator<Crypto>> SORT_MAP = Map.of(
        "name",     Comparator.comparing(Crypto::getName, String.CASE_INSENSITIVE_ORDER),
        "price",    Comparator.comparingDouble(Crypto::getPrice),
        "quantity", Comparator.comparingDouble(Crypto::getQuantity)
    );

    public Crypto addCrypto(Crypto crypto) {
        crypto.setId(nextId++);
        portfolio.add(crypto);
        return crypto;
    }

    public List<Crypto> getAllCryptos(String sortBy) {
        if (sortBy == null) {
            return new ArrayList<>(portfolio);
        }
        Comparator<Crypto> comparator = SORT_MAP.get(sortBy);
        if (comparator == null) {
            return new ArrayList<>(portfolio);
        }
        return portfolio.stream().sorted(comparator).toList();
    }

    public Optional<Crypto> findById(int id) {
        return portfolio.stream()
                .filter(c -> c.getId().equals(id))
                .findFirst();
    }

    public Optional<Crypto> updateCrypto(int id, Crypto updated) {
        return findById(id).map(existing -> {
            existing.setName(updated.getName());
            existing.setSymbol(updated.getSymbol());
            existing.setPrice(updated.getPrice());
            existing.setQuantity(updated.getQuantity());
            return existing;
        });
    }

    public double calculatePortfolioValue() {
        return portfolio.stream()
                .mapToDouble(c -> c.getPrice() * c.getQuantity())
                .sum();
    }
}
