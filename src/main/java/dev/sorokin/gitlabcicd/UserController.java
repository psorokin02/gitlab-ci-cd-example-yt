package dev.sorokin.gitlabcicd;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("/api")
public class UserController {

    @GetMapping(value = "/users")
    public ResponseEntity<List<User>> getUsers() {
        var userList = List.of(
                new User("Artem", 20),
                new User("Kirill", 20)
                );
        return ResponseEntity.ok(userList);
    }

    public record User (
            String name,
            Integer age
    ) {}
}
