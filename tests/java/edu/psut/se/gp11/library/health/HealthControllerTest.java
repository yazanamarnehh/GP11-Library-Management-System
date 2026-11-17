package edu.psut.se.gp11.library.health;

import static org.assertj.core.api.Assertions.assertThat;

import java.util.Map;

import org.junit.jupiter.api.Test;

/**
 * Unit test: HealthController reports the application as UP.
 */
class HealthControllerTest {

    @Test
    void healthReportsUp() {
        Map<String, String> body = new HealthController().health();

        assertThat(body).containsEntry("status", "UP");
    }
}
