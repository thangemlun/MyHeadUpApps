package com.thienday.headup.data.repositories;

import com.thienday.headup.data.entities.UserEntity;
import jakarta.persistence.LockModeType;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Lock;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

public interface UserRepository extends JpaRepository<UserEntity, Long> {

    @Query(value = "select u.* from public.\"user\" u where u.email = :email", nativeQuery = true)
    UserEntity findUserByEmail(String email);

    @Query(value = "select count(*) > 0 from public.\"user\" u where u.email = :email",
            nativeQuery = true)
    boolean checkExistEmail(String email);

    @Query(value = "select count(*) > 0 from public.\"user\" u where u.username = :username",
            nativeQuery = true)
    boolean checkExistActivatedUsername(String username);

    @Query(value = "select count(*) > 0 from public.\"user\" u where u.email = :email and u.mail_activated is not true",
            nativeQuery = true)
    boolean checkEmailNeedToActivate(String email);

    @Modifying
    @Transactional(isolation = Isolation.SERIALIZABLE)
    @Query(value = "update public.\"user\" set mail_activated = true where email = :email ", nativeQuery = true)
    void activateMail(String email);

    @Query(value = "select count(*) > 0 from public.\"user\" u where u.email = :email and u.mail_activated = true",
            nativeQuery = true)
    boolean checkExistAndVerifiedEmail(String email);
}
